"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getConnection = getConnection;
exports.createInitialOrder = createInitialOrder;
exports.updateOrderWithSnapInfo = updateOrderWithSnapInfo;
exports.updateOrderStatus = updateOrderStatus;
exports.getOrderById = getOrderById;
exports.getOrderByNumber = getOrderByNumber;
exports.getUserOrders = getUserOrders;
const database_1 = require("../config/database");
function getConnection() {
    return __awaiter(this, void 0, void 0, function* () {
        return yield database_1.pool.getConnection();
    });
}
function createInitialOrder(connection, orderData, items) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const { userId, customerName, email, phone, address, subtotal, shipping, total, paymentMethod, status, voucherId, voucherCode, voucherDiscount, } = orderData;
            // Create initial order dengan data voucher
            const [orderResult] = yield connection.query(`INSERT INTO orders
      (user_id, customer_name, email, phone, address, subtotal,
      shipping_fee, total, payment_method, order_date, status,
      voucher_id, voucher_code, voucher_discount)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?)`, [
                userId,
                customerName,
                email,
                phone,
                address,
                subtotal,
                shipping,
                total,
                paymentMethod,
                status,
                voucherId,
                voucherCode,
                voucherDiscount || 0,
            ]);
            const orderId = orderResult.insertId;
            // Insert order items
            for (const item of items) {
                yield connection.query(`INSERT INTO order_items
        (order_id, product_id, product_name, price, quantity, subtotal)
        VALUES (?, ?, ?, ?, ?, ?)`, [
                    orderId,
                    item.id,
                    item.name,
                    item.price,
                    item.quantity,
                    item.price * item.quantity,
                ]);
            }
            // Generate order number
            const orderNumber = `KKS-${orderId}-${Date.now().toString().slice(-6)}`;
            // Update order with order number
            yield connection.query("UPDATE orders SET order_number = ? WHERE id = ?", [
                orderNumber,
                orderId,
            ]);
            return {
                orderId,
                orderNumber,
            };
        }
        catch (error) {
            throw error;
        }
    });
}
function updateOrderWithSnapInfo(connection, orderId, snapToken, redirectUrl) {
    return __awaiter(this, void 0, void 0, function* () {
        yield connection.query(`UPDATE orders
    SET snap_token = ?, snap_redirect_url = ?
    WHERE id = ?`, [snapToken, redirectUrl, orderId]);
    });
}
function updateOrderStatus(orderNumber_1, status_1, transactionId_1, transactionTime_1) {
    return __awaiter(this, arguments, void 0, function* (orderNumber, status, transactionId, transactionTime, vaNumber = null, bank = null, fraudStatus = null, paymentType = null) {
        const connection = yield database_1.pool.getConnection();
        try {
            let query = `
      UPDATE orders
      SET status = ?,
          transaction_id = ?,
          transaction_time = ?,
          va_number = ?,
          bank = ?,
          fraud_status = ?`;
            if (paymentType) {
                query += `, payment_method = ?`;
            }
            query += ` WHERE order_number = ?`;
            const params = paymentType
                ? [
                    status,
                    transactionId,
                    transactionTime,
                    vaNumber,
                    bank,
                    fraudStatus,
                    paymentType,
                    orderNumber,
                ]
                : [
                    status,
                    transactionId,
                    transactionTime,
                    vaNumber,
                    bank,
                    fraudStatus,
                    orderNumber,
                ];
            yield connection.query(query, params);
        }
        catch (error) {
            throw error;
        }
        finally {
            connection.release();
        }
    });
}
function getOrderById(orderId) {
    return __awaiter(this, void 0, void 0, function* () {
        const [orders] = yield database_1.pool.query(`SELECT o.*, 
            v.name as voucher_name,
            v.description as voucher_description,
            v.discount_type as voucher_discount_type,
            v.discount_value as voucher_discount_value
     FROM orders o
     LEFT JOIN vouchers v ON o.voucher_id = v.id
     WHERE o.id = ?`, [orderId]);
        if (orders.length === 0) {
            return null;
        }
        // Get order items
        const [items] = yield database_1.pool.query(`SELECT * FROM order_items WHERE order_id = ?`, [orderId]);
        const order = orders[0];
        // Format voucher information jika ada
        let voucherInfo = null;
        if (order.voucher_id) {
            voucherInfo = {
                id: order.voucher_id,
                code: order.voucher_code,
                name: order.voucher_name,
                description: order.voucher_description,
                discountType: order.voucher_discount_type,
                discountValue: order.voucher_discount_value,
                discountAmount: order.voucher_discount,
            };
        }
        return {
            order: Object.assign(Object.assign({}, order), { voucher: voucherInfo }),
            items: items,
        };
    });
}
// Tambahan function untuk get order by order number
function getOrderByNumber(orderNumber) {
    return __awaiter(this, void 0, void 0, function* () {
        const [orders] = yield database_1.pool.query(`SELECT o.*, 
            v.name as voucher_name,
            v.description as voucher_description,
            v.discount_type as voucher_discount_type,
            v.discount_value as voucher_discount_value
     FROM orders o
     LEFT JOIN vouchers v ON o.voucher_id = v.id
     WHERE o.order_number = ?`, [orderNumber]);
        if (orders.length === 0) {
            return null;
        }
        // Get order items
        const [items] = yield database_1.pool.query(`SELECT * FROM order_items WHERE order_id = ?`, [orders[0].id]);
        const order = orders[0];
        // Format voucher information jika ada
        let voucherInfo = null;
        if (order.voucher_id) {
            voucherInfo = {
                id: order.voucher_id,
                code: order.voucher_code,
                name: order.voucher_name,
                description: order.voucher_description,
                discountType: order.voucher_discount_type,
                discountValue: order.voucher_discount_value,
                discountAmount: order.voucher_discount,
            };
        }
        return {
            order: Object.assign(Object.assign({}, order), { voucher: voucherInfo }),
            items: items,
        };
    });
}
function getUserOrders(userId) {
    return __awaiter(this, void 0, void 0, function* () {
        const [orders] = yield database_1.pool.query(`SELECT o.*, 
            v.name as voucher_name,
            v.description as voucher_description,
            v.discount_type as voucher_discount_type,
            v.discount_value as voucher_discount_value,
            (SELECT COUNT(*) FROM order_items WHERE order_id = o.id) as item_count
     FROM orders o
     LEFT JOIN vouchers v ON o.voucher_id = v.id
     WHERE o.user_id = ?
     ORDER BY o.order_date DESC`, [userId]);
        // Get items for each order dan format voucher info
        for (const order of orders) {
            const [items] = yield database_1.pool.query(`SELECT * FROM order_items WHERE order_id = ?`, [order.id]);
            order.items = items;
            // Format voucher information jika ada
            if (order.voucher_id) {
                order.voucher = {
                    id: order.voucher_id,
                    code: order.voucher_code,
                    name: order.voucher_name,
                    description: order.voucher_description,
                    discountType: order.voucher_discount_type,
                    discountValue: order.voucher_discount_value,
                    discountAmount: order.voucher_discount,
                };
            }
            else {
                order.voucher = null;
            }
        }
        return orders;
    });
}
