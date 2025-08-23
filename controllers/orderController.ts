import { Request, Response } from "express";
import * as orderModel from "../models/orderModel";
import * as voucherModel from "../models/voucherModel";
import midtransClient from "midtrans-client";

// Create Midtrans Snap API instance
const snap = new midtransClient.Snap({
  isProduction: process.env.MIDTRANS_IS_PRODUCTION === "true",
  serverKey: process.env.MIDTRANS_SERVER_KEY,
  clientKey: process.env.MIDTRANS_CLIENT_KEY,
});

// Create Midtrans Core API instance for handling notifications
const core = new midtransClient.CoreApi({
  isProduction: process.env.MIDTRANS_IS_PRODUCTION === "true",
  serverKey: process.env.MIDTRANS_SERVER_KEY,
  clientKey: process.env.MIDTRANS_CLIENT_KEY,
});

interface OrderItem {
    id: number;
    price: number;
    quantity: number;
    name: string;
}

interface CreateOrderRequestBody {
    customerName: string;
    email: string;
    phone: string;
    address: string;
    items: OrderItem[];
    subtotal: number;
    shipping: number;
    total: number;
    paymentMethod: string;
    voucherCode?: string;
    voucherDiscount?: number;
}

async function createOrder(req: Request, res: Response): Promise<Response> {
    const {
        customerName,
        email,
        phone,
        address,
        items,
        subtotal,
        shipping,
        total,
        paymentMethod,
        voucherCode,
        voucherDiscount,
    }: CreateOrderRequestBody = req.body;

    const userId = req.session?.userId || null;
    const connection = await orderModel.getConnection();
    await connection.beginTransaction();

    try {
        let finalVoucherId: number | null = null;
        let finalVoucherCode: string | null = null;
        let finalVoucherDiscount = 0;
        let voucherDetails: any = null; // Tambahan untuk menyimpan detail voucher

        // Validasi voucher jika ada
        if (voucherCode && voucherDiscount && voucherDiscount > 0) {
            const voucherResult = await voucherModel.validateVoucher(
                voucherCode,
                userId,
                email,
                subtotal + shipping
            );

            if (!voucherResult.valid || !voucherResult.voucher) {
                await connection.rollback();
                return res.status(400).json({
                    success: false,
                    error: voucherResult.message,
                });
            }

            finalVoucherId = voucherResult.voucher.id;
            finalVoucherCode = voucherCode;
            finalVoucherDiscount = voucherResult.discountAmount || 0;

            // Simpan detail voucher untuk response
            voucherDetails = {
                id: voucherResult.voucher.id,
                code: voucherResult.voucher.code,
                name: voucherResult.voucher.name,
                description: voucherResult.voucher.description,
                discountType: voucherResult.voucher.discount_type,
                discountValue: voucherResult.voucher.discount_value,
                discountAmount: voucherResult.discountAmount,
            };
        }

        const orderData = {
            userId,
            customerName,
            email,
            phone,
            address,
            subtotal,
            shipping,
            total,
            paymentMethod,
            status: "pending",
            voucherId: finalVoucherId,
            voucherCode: finalVoucherCode,
            voucherDiscount: finalVoucherDiscount,
        };

        const result = await orderModel.createInitialOrder(
            connection,
            orderData,
            items
        );

        const { orderId, orderNumber } = result;

        // Catat penggunaan voucher
        if (finalVoucherId) {
            await voucherModel.recordVoucherUsage(finalVoucherId, userId, email);
        }

        const itemDetails = items.map((item) => ({
            id: item.id.toString(),
            price: item.price,
            quantity: item.quantity,
            name: item.name,
        }));

        if (shipping > 0) {
            itemDetails.push({
                id: "SHIPPING",
                price: shipping,
                quantity: 1,
                name: "Shipping Fee",
            });
        }

        // Tambah item diskon voucher jika ada
        if (finalVoucherDiscount > 0) {
            itemDetails.push({
                id: "VOUCHER_DISCOUNT",
                price: -finalVoucherDiscount,
                quantity: 1,
                name: `Diskon Voucher ${finalVoucherCode}`,
            });
        }

        const transactionDetails = {
            order_id: orderNumber,
            gross_amount: total,
        };

        const customerDetails = {
            first_name: customerName,
            email: email,
            phone: phone,
            billing_address: { address },
            shipping_address: { address },
        };

        const midtransParameter: any = {
            transaction_details: transactionDetails,
            customer_details: customerDetails,
            item_details: itemDetails,
        };

        if (paymentMethod && paymentMethod !== "all") {
            midtransParameter.enabled_payments = [paymentMethod];
        }

        const snapResponse = await snap.createTransaction(midtransParameter);

        await orderModel.updateOrderWithSnapInfo(
            connection,
            orderId,
            snapResponse.token,
            snapResponse.redirect_url
        );

        await connection.commit();

        // Response dengan detail voucher
        const response: any = {
            success: true,
            message: "Pesanan berhasil dibuat",
            orderId: orderId,
            orderNumber: orderNumber,
            snapToken: snapResponse.token,
            redirectUrl: snapResponse.redirect_url,
        };

        // Tambahkan detail voucher jika ada
        if (voucherDetails) {
            response.voucher = voucherDetails;
        }

        return res.status(201).json(response);
    } catch (error: any) {
        await connection.rollback();
        console.error("Order creation error:", error);
        return res
            .status(500)
            .json({ error: "Gagal membuat pesanan", details: error.message });
    } finally {
        connection.release();
    }
}

async function getOrderById(req: Request, res: Response): Promise<Response> {
    const orderId = req.params.id;
    try {
        const orderData = await orderModel.getOrderById(orderId);
        if (!orderData) {
            return res.status(404).json({ error: "Pesanan tidak ditemukan" });
        }
        return res.json(orderData);
    } catch (error: any) {
        console.error("Error fetching order:", error);
        return res.status(500).json({ error: "Gagal mengambil data pesanan" });
    }
}

// Tambahan function untuk get order by order number (untuk transaction success page)
async function getOrderByNumber(req: Request, res: Response): Promise<Response> {
    const orderNumber = req.params.orderNumber;
    try {
        const orderData = await orderModel.getOrderByNumber(orderNumber);
        if (!orderData) {
            return res.status(404).json({ error: "Pesanan tidak ditemukan" });
        }
        return res.json({
            success: true,
            data: orderData,
        });
    } catch (error: any) {
        console.error("Error fetching order by number:", error);
        return res.status(500).json({ error: "Gagal mengambil data pesanan" });
    }
}

async function getUserOrders(req: Request, res: Response): Promise<Response> {
    if (!req.session.userId) {
        return res.status(401).json({ error: "Unauthorized" });
    }
    try {
        const orders = await orderModel.getUserOrders(req.session.userId);
        return res.json(orders);
    } catch (error: any) {
        console.error("Error fetching orders:", error);
        return res.status(500).json({ error: "Failed to fetch orders" });
    }
}

async function handleMidtransWebhook(req: Request, res: Response): Promise<Response> {
    try {
        const notificationJson = req.body;
        const statusResponse = await core.transaction.notification(
            notificationJson
        );

        const orderId = statusResponse.order_id;
        const transactionStatus = statusResponse.transaction_status;
        const fraudStatus = statusResponse.fraud_status;
        const transactionId = statusResponse.transaction_id;
        const transactionTime = statusResponse.transaction_time;
        const paymentType = statusResponse.payment_type;

        let vaNumber: string | null = null;
        let bank: string | null = null;

        if (paymentType === "bank_transfer") {
            const vaNumbers = statusResponse.va_numbers;
            if (vaNumbers && vaNumbers.length > 0) {
                vaNumber = vaNumbers[0].va_number;
                bank = vaNumbers[0].bank;
            }
        }

        let orderStatus: string;
        switch (transactionStatus) {
            case "capture":
                orderStatus = fraudStatus === "challenge" ? "challenge" : "settlement";
                break;
            case "settlement":
                orderStatus = "settlement";
                break;
            case "deny":
                orderStatus = "deny";
                break;
            case "cancel":
            case "expire":
                orderStatus = transactionStatus;
                break;
            case "pending":
                orderStatus = "pending";
                break;
            default:
                orderStatus = transactionStatus;
        }

        await orderModel.updateOrderStatus(
            orderId,
            orderStatus,
            transactionId,
            transactionTime,
            vaNumber,
            bank,
            fraudStatus,
            paymentType
        );

        return res.status(200).json({ status: "OK" });
    } catch (error: any) {
        console.error("Webhook processing error:", error);
        return res.status(500).json({ status: "Error", message: error.message });
    }
}

async function updatePaymentMethod(req: Request, res: Response): Promise<Response> {
    const { orderNumber } = req.params;
    const { paymentMethod, transactionStatus, transactionId } = req.body;

    if (!orderNumber || !paymentMethod) {
        return res.status(400).json({
            success: false,
            error:
                "Missing required fields: orderNumber and paymentMethod are required",
        });
    }

    try {
        const statusResponse = await core.transaction.status(transactionId);

        if (statusResponse.order_id !== orderNumber) {
            return res.status(400).json({
                success: false,
                error: "Transaction ID does not match order number",
            });
        }

        let orderStatus: string;
        switch (statusResponse.transaction_status || transactionStatus) {
            case "capture":
            case "settlement":
                orderStatus = "settlement";
                break;
            case "deny":
                orderStatus = "deny";
                break;
            case "cancel":
            case "expire":
                orderStatus = statusResponse.transaction_status || transactionStatus;
                break;
            case "pending":
            default:
                orderStatus = "pending";
                break;
        }

        await orderModel.updateOrderStatus(
            orderNumber,
            orderStatus,
            transactionId,
            statusResponse.transaction_time || new Date().toISOString(),
            statusResponse.va_numbers?.[0]?.va_number || null,
            statusResponse.va_numbers?.[0]?.bank || null,
            statusResponse.fraud_status || null,
            paymentMethod
        );

        return res.status(200).json({
            success: true,
            message: "Payment method updated successfully",
        });
    } catch (error: any) {
        console.error("Error updating payment method:", error);
        return res.status(500).json({
            success: false,
            error: "Failed to update payment method",
            details: error.message,
        });
    }
}

export {
    createOrder,
    getOrderById,
    getOrderByNumber,
    getUserOrders,
    handleMidtransWebhook,
    updatePaymentMethod,
};