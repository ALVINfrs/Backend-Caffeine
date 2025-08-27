import { Request, Response } from "express";

import { pool as db } from "./../../config/database";

// Mendapatkan semua voucher
export const getAllVouchers = async (req: Request, res: Response) => {
  try {
    const [vouchers] = await db.query(
      "SELECT * FROM vouchers ORDER BY created_at DESC"
    );
    res.json(vouchers);
  } catch (error) {
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Membuat voucher baru
export const createVoucher = async (req: Request, res: Response) => {
  const {
    code,
    name,
    description,
    discount_type,
    discount_value,
    min_order,
    max_discount,
    is_active,
  } = req.body;

  try {
    const [result]: any = await db.query(
      "INSERT INTO vouchers (code, name, description, discount_type, discount_value, min_order, max_discount, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [
        code,
        name,
        description,
        discount_type,
        discount_value,
        min_order,
        max_discount,
        is_active || 1,
      ]
    );
    res.status(201).json({ id: result.insertId, ...req.body });
  } catch (error) {
    // @ts-ignore
    if (error.code === "ER_DUP_ENTRY") {
      return res.status(400).json({ message: "Kode voucher sudah ada." });
    }
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Memperbarui voucher
export const updateVoucher = async (req: Request, res: Response) => {
  const { id } = req.params;
  const {
    code,
    name,
    description,
    discount_type,
    discount_value,
    min_order,
    max_discount,
    is_active,
  } = req.body;

  try {
    const [result]: any = await db.query(
      "UPDATE vouchers SET code = ?, name = ?, description = ?, discount_type = ?, discount_value = ?, min_order = ?, max_discount = ?, is_active = ? WHERE id = ?",
      [
        code,
        name,
        description,
        discount_type,
        discount_value,
        min_order,
        max_discount,
        is_active,
        id,
      ]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Voucher tidak ditemukan" });
    }
    res.json({ message: "Voucher berhasil diperbarui" });
  } catch (error) {
    // @ts-ignore
    if (error.code === "ER_DUP_ENTRY") {
      return res.status(400).json({ message: "Kode voucher sudah ada." });
    }
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Menghapus voucher
export const deleteVoucher = async (req: Request, res: Response) => {
  try {
    const [result]: any = await db.query("DELETE FROM vouchers WHERE id = ?", [
      req.params.id,
    ]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Voucher tidak ditemukan" });
    }
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ message: "Internal Server Error" });
  }
};
