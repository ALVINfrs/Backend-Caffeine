import { Request, Response } from "express";
import * as voucherModel from "../models/voucherModel";

interface ValidateVoucherBody {
    voucherCode: string;
    total: string;
    email?: string;
}

// Validasi voucher saat user input kode
async function validateVoucher(req: Request, res: Response): Promise<Response> {
    try {
        const { voucherCode, total, email: bodyEmail }: ValidateVoucherBody = req.body;
        const userId = req.session?.userId || null;
        const email = bodyEmail || req.session?.user?.email;

        if (!voucherCode || !total || !email) {
            return res.status(400).json({
                success: false,
                message: "Data tidak lengkap",
            });
        }

        const result = await voucherModel.validateVoucher(
            voucherCode.toUpperCase(),
            userId,
            email,
            parseFloat(total)
        );

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
        } else {
            return res.status(400).json({
                success: false,
                message: result.message,
            });
        }
    } catch (error: any) {
        console.error("Error validating voucher:", error);
        return res.status(500).json({
            success: false,
            message: "Gagal memvalidasi voucher",
        });
    }
}

// Ambil daftar voucher aktif
async function getActiveVouchers(req: Request, res: Response): Promise<Response> {
    try {
        const vouchers = await voucherModel.getActiveVouchers();
        return res.json({
            success: true,
            vouchers: vouchers,
        });
    } catch (error: any) {
        console.error("Error fetching vouchers:", error);
        return res.status(500).json({
            success: false,
            message: "Gagal mengambil data voucher",
        });
    }
}

export {
    validateVoucher,
    getActiveVouchers,
};
