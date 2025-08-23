import express from "express";
import * as voucherController from "../controllers/voucherController";

const router = express.Router();

// Route untuk validasi voucher
router.post("/validate", voucherController.validateVoucher);

// Route untuk ambil daftar voucher aktif
router.get("/active", voucherController.getActiveVouchers);

export default router;
