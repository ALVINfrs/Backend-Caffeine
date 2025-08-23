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
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateVoucher = validateVoucher;
exports.getActiveVouchers = getActiveVouchers;
const voucherModel = __importStar(require("../models/voucherModel"));
// Validasi voucher saat user input kode
function validateVoucher(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a, _b, _c;
        try {
            const { voucherCode, total, email: bodyEmail } = req.body;
            const userId = ((_a = req.session) === null || _a === void 0 ? void 0 : _a.userId) || null;
            const email = bodyEmail || ((_c = (_b = req.session) === null || _b === void 0 ? void 0 : _b.user) === null || _c === void 0 ? void 0 : _c.email);
            if (!voucherCode || !total || !email) {
                return res.status(400).json({
                    success: false,
                    message: "Data tidak lengkap",
                });
            }
            const result = yield voucherModel.validateVoucher(voucherCode.toUpperCase(), userId, email, parseFloat(total));
            if (result.valid && result.voucher) {
                return res.json({
                    success: true,
                    message: result.message,
                    voucher: {
                        id: result.voucher.id,
                        code: result.voucher.code,
                        name: result.voucher.name,
                        discountAmount: result.discountAmount,
                    },
                });
            }
            else {
                return res.status(400).json({
                    success: false,
                    message: result.message,
                });
            }
        }
        catch (error) {
            console.error("Error validating voucher:", error);
            return res.status(500).json({
                success: false,
                message: "Gagal memvalidasi voucher",
            });
        }
    });
}
// Ambil daftar voucher aktif
function getActiveVouchers(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const vouchers = yield voucherModel.getActiveVouchers();
            return res.json({
                success: true,
                vouchers: vouchers,
            });
        }
        catch (error) {
            console.error("Error fetching vouchers:", error);
            return res.status(500).json({
                success: false,
                message: "Gagal mengambil data voucher",
            });
        }
    });
}
