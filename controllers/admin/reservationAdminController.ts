import { Request, Response } from "express";
import { pool as db } from "./../../config/database";
import { RowDataPacket, ResultSetHeader } from "mysql2";

// Add interface for Reservation
interface Reservation extends RowDataPacket {
  id: number;
  customer_name: string;
  phone: string;
  reservation_date: Date;
  reservation_time: string;
  guest_count: number;
  table_number: number;
  status: string;
}

// Mendapatkan semua reservasi dengan paginasi dan filter
export const getAllReservations = async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string) || 1;
  const limit = parseInt(req.query.limit as string) || 10;
  const offset = (page - 1) * limit;
  const status = req.query.status as string;

  let query = "SELECT * FROM reservations";
  let countQuery = "SELECT COUNT(*) as total FROM reservations";
  const params: any[] = [];

  if (status) {
    query += " WHERE status = ?";
    countQuery += " WHERE status = ?";
    params.push(status);
  }

  query +=
    " ORDER BY reservation_date DESC, reservation_time DESC LIMIT ? OFFSET ?";
  params.push(limit, offset);

  try {
    const [reservations] = await db.query<Reservation[]>(query, params);
    const [[{ total }]] = await db.query<(RowDataPacket & { total: number })[]>(
      countQuery,
      status ? [status] : []
    );

    res.json({
      data: reservations,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    console.error("Error fetching reservations:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Mendapatkan reservasi berdasarkan ID
export const getReservationById = async (req: Request, res: Response) => {
  try {
    const [reservation] = await db.query<Reservation[]>(
      "SELECT * FROM reservations WHERE id = ?",
      [req.params.id]
    );

    if (reservation.length === 0) {
      return res.status(404).json({ message: "Reservasi tidak ditemukan" });
    }
    res.json(reservation[0]);
  } catch (error) {
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Memperbarui status atau detail reservasi
export const updateReservation = async (req: Request, res: Response) => {
  const { id } = req.params;
  const {
    status,
    customer_name,
    phone,
    reservation_date,
    reservation_time,
    guest_count,
    table_number,
  } = req.body;

  try {
    const [result] = await db.query<ResultSetHeader>(
      "UPDATE reservations SET status = ?, customer_name = ?, phone = ?, reservation_date = ?, reservation_time = ?, guest_count = ?, table_number = ? WHERE id = ?",
      [
        status,
        customer_name,
        phone,
        reservation_date,
        reservation_time,
        guest_count,
        table_number,
        id,
      ]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Reservasi tidak ditemukan" });
    }
    res.json({ message: "Reservasi berhasil diperbarui" });
  } catch (error) {
    console.error("Error updating reservation:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Menghapus reservasi
export const deleteReservation = async (req: Request, res: Response) => {
  try {
    const [result] = await db.query<ResultSetHeader>(
      "DELETE FROM reservations WHERE id = ?",
      [req.params.id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Reservasi tidak ditemukan" });
    }
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ message: "Internal Server Error" });
  }
};
