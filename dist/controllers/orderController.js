"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.createOrder = createOrder;
exports.getOrderById = getOrderById;
exports.getOrderByNumber = getOrderByNumber;
exports.getUserOrders = getUserOrders;
exports.handleMidtransWebhook = handleMidtransWebhook;
exports.updatePaymentMethod = updatePaymentMethod;
const orderModel = __importStar(require("../models/orderModel"));
const voucherModel = __importStar(require("../models/voucherModel"));
const midtrans_client_1 = __importDefault(require("midtrans-client"));
// Create Midtrans Snap API instance
const snap = new midtrans_client_1.default.Snap({
    isProduction: process.env.MIDTRANS_IS_PRODUCTION === "true",
    serverKey: process.env.MIDTRANS_SERVER_KEY,
    clientKey: process.env.MIDTRANS_CLIENT_KEY,
});
// Create Midtrans Core API instance for handling notifications
const core = new midtrans_client_1.default.CoreApi({
    isProduction: process.env.MIDTRANS_IS_PRODUCTION === "true",
    serverKey: process.env.MIDTRANS_SERVER_KEY,
    clientKey: process.env.MIDTRANS_CLIENT_KEY,
});
function createOrder(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a;
        const { customerName, email, phone, address, items, subtotal, shipping, total, paymentMethod, voucherCode, voucherDiscount, } = req.body;
        const userId = ((_a = req.session) === null || _a === void 0 ? void 0 : _a.userId) || null;
        const connection = yield orderModel.getConnection();
        yield connection.beginTransaction();
        try {
            let finalVoucherId = null;
            let finalVoucherCode = null;
            let finalVoucherDiscount = 0;
            let voucherDetails = null; // Tambahan untuk menyimpan detail voucher
            // Validasi voucher jika ada
            if (voucherCode && voucherDiscount && voucherDiscount > 0) {
                const voucherResult = yield voucherModel.validateVoucher(voucherCode, userId, email, subtotal + shipping);
                if (!voucherResult.valid || !voucherResult.voucher) {
                    yield connection.rollback();
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
            const result = yield orderModel.createInitialOrder(connection, orderData, items);
            const { orderId, orderNumber } = result;
            // Catat penggunaan voucher
            if (finalVoucherId) {
                yield voucherModel.recordVoucherUsage(finalVoucherId, userId, email);
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
            const midtransParameter = {
                transaction_details: transactionDetails,
                customer_details: customerDetails,
                item_details: itemDetails,
            };
            if (paymentMethod && paymentMethod !== "all") {
                midtransParameter.enabled_payments = [paymentMethod];
            }
            const snapResponse = yield snap.createTransaction(midtransParameter);
            yield orderModel.updateOrderWithSnapInfo(connection, orderId, snapResponse.token, snapResponse.redirect_url);
            yield connection.commit();
            // Response dengan detail voucher
            const response = {
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
        }
        catch (error) {
            yield connection.rollback();
            console.error("Order creation error:", error);
            return res
                .status(500)
                .json({ error: "Gagal membuat pesanan", details: error.message });
        }
        finally {
            connection.release();
        }
    });
}
function getOrderById(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const orderId = req.params.id;
        try {
            const orderData = yield orderModel.getOrderById(orderId);
            if (!orderData) {
                return res.status(404).json({ error: "Pesanan tidak ditemukan" });
            }
            return res.json(orderData);
        }
        catch (error) {
            console.error("Error fetching order:", error);
            return res.status(500).json({ error: "Gagal mengambil data pesanan" });
        }
    });
}
// Tambahan function untuk get order by order number (untuk transaction success page)
function getOrderByNumber(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const orderNumber = req.params.orderNumber;
        try {
            const orderData = yield orderModel.getOrderByNumber(orderNumber);
            if (!orderData) {
                return res.status(404).json({ error: "Pesanan tidak ditemukan" });
            }
            return res.json({
                success: true,
                data: orderData,
            });
        }
        catch (error) {
            console.error("Error fetching order by number:", error);
            return res.status(500).json({ error: "Gagal mengambil data pesanan" });
        }
    });
}
function getUserOrders(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        if (!req.session.userId) {
            return res.status(401).json({ error: "Unauthorized" });
        }
        try {
            const orders = yield orderModel.getUserOrders(req.session.userId);
            return res.json(orders);
        }
        catch (error) {
            console.error("Error fetching orders:", error);
            return res.status(500).json({ error: "Failed to fetch orders" });
        }
    });
}
function handleMidtransWebhook(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const notificationJson = req.body;
            const statusResponse = yield core.transaction.notification(notificationJson);
            const orderId = statusResponse.order_id;
            const transactionStatus = statusResponse.transaction_status;
            const fraudStatus = statusResponse.fraud_status;
            const transactionId = statusResponse.transaction_id;
            const transactionTime = statusResponse.transaction_time;
            const paymentType = statusResponse.payment_type;
            let vaNumber = null;
            let bank = null;
            if (paymentType === "bank_transfer") {
                const vaNumbers = statusResponse.va_numbers;
                if (vaNumbers && vaNumbers.length > 0) {
                    vaNumber = vaNumbers[0].va_number;
                    bank = vaNumbers[0].bank;
                }
            }
            let orderStatus;
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
            yield orderModel.updateOrderStatus(orderId, orderStatus, transactionId, transactionTime, vaNumber, bank, fraudStatus, paymentType);
            return res.status(200).json({ status: "OK" });
        }
        catch (error) {
            console.error("Webhook processing error:", error);
            return res.status(500).json({ status: "Error", message: error.message });
        }
    });
}
function updatePaymentMethod(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a, _b, _c, _d;
        const { orderNumber } = req.params;
        const { paymentMethod, transactionStatus, transactionId } = req.body;
        if (!orderNumber || !paymentMethod) {
            return res.status(400).json({
                success: false,
                error: "Missing required fields: orderNumber and paymentMethod are required",
            });
        }
        try {
            const statusResponse = yield core.transaction.status(transactionId);
            if (statusResponse.order_id !== orderNumber) {
                return res.status(400).json({
                    success: false,
                    error: "Transaction ID does not match order number",
                });
            }
            let orderStatus;
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
            yield orderModel.updateOrderStatus(orderNumber, orderStatus, transactionId, statusResponse.transaction_time || new Date().toISOString(), ((_b = (_a = statusResponse.va_numbers) === null || _a === void 0 ? void 0 : _a[0]) === null || _b === void 0 ? void 0 : _b.va_number) || null, ((_d = (_c = statusResponse.va_numbers) === null || _c === void 0 ? void 0 : _c[0]) === null || _d === void 0 ? void 0 : _d.bank) || null, statusResponse.fraud_status || null, paymentMethod);
            return res.status(200).json({
                success: true,
                message: "Payment method updated successfully",
            });
        }
        catch (error) {
            console.error("Error updating payment method:", error);
            return res.status(500).json({
                success: false,
                error: "Failed to update payment method",
                details: error.message,
            });
        }
    });
}
