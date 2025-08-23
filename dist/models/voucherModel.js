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
exports.validateVoucher = validateVoucher;
exports.recordVoucherUsage = recordVoucherUsage;
exports.getActiveVouchers = getActiveVouchers;
const database_1 = require("../config/database");
// Cek voucher valid dan belum digunakan user
function validateVoucher(voucherCode, userId, email, orderTotal) {
    return __awaiter(this, void 0, void 0, function* () {
        const connection = yield database_1.pool.getConnection();
        try {
            // Cek voucher ada dan aktif
            const [vouchers] = yield connection.query(`SELECT * FROM vouchers WHERE code = ? AND is_active = 1`, [voucherCode]);
            if (vouchers.length === 0) {
                return {
                    valid: false,
                    message: "Kode voucher tidak valid atau sudah tidak aktif",
                };
            }
            const voucher = vouchers[0];
            // Cek minimum order
            if (orderTotal < voucher.min_order) {
                return {
                    valid: false,
                    message: `Minimum order Rp ${voucher.min_order.toLocaleString("id-ID")} untuk menggunakan voucher ini`,
                };
            }
            // Cek apakah user sudah menggunakan voucher ini
            const [usageCheck] = yield connection.query(`SELECT id FROM user_voucher_usage
       WHERE voucher_id = ? AND (user_id = ? OR email = ?)`, [voucher.id, userId, email]);
            if (usageCheck.length > 0) {
                return {
                    valid: false,
                    message: "Anda sudah menggunakan voucher ini sebelumnya",
                };
            }
            // Hitung diskon
            let discountAmount = 0;
            if (voucher.discount_type === "percentage") {
                discountAmount = (orderTotal * voucher.discount_value) / 100;
                if (voucher.max_discount && discountAmount > voucher.max_discount) {
                    discountAmount = voucher.max_discount;
                }
            }
            else {
                discountAmount = voucher.discount_value;
            }
            return {
                valid: true,
                voucher: voucher,
                discountAmount: discountAmount,
                message: "Voucher berhasil diterapkan",
            };
        }
        catch (error) {
            throw error;
        }
        finally {
            connection.release();
        }
    });
}
// Catat penggunaan voucher
function recordVoucherUsage(voucherId, userId, email) {
    return __awaiter(this, void 0, void 0, function* () {
        const connection = yield database_1.pool.getConnection();
        try {
            yield connection.query(`INSERT INTO user_voucher_usage (voucher_id, user_id, email) VALUES (?, ?, ?)`, [voucherId, userId, email]);
        }
        catch (error) {
            throw error;
        }
        finally {
            connection.release();
        }
    });
}
// Ambil semua voucher aktif (untuk ditampilkan ke user)
function getActiveVouchers() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const [vouchers] = yield database_1.pool.query(`SELECT code, name, description, discount_type, discount_value, min_order, max_discount
       FROM vouchers WHERE is_active = 1 ORDER BY name`);
            return vouchers;
        }
        catch (error) {
            throw error;
        }
    });
}
