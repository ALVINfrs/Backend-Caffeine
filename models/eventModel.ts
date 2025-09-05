import { pool } from "../config/database";
import { RowDataPacket } from "mysql2";

export interface Event extends RowDataPacket {
  id: number;
  title: string;
  description: string;
  image: string;
  speaker: string;
  date: string;
  time: string;
  type: string;
  is_active: boolean;
}

/**
 * Mengambil semua event yang aktif dan akan datang.
 */
export async function getActiveEvents(): Promise<Event[]> {
  const [rows] = await pool.query<Event[]>(
    "SELECT * FROM events WHERE is_active = 1 AND date >= CURDATE() ORDER BY date ASC, time ASC"
  );
  return rows;
}

/**
 * Mengambil detail satu event berdasarkan ID.
 */
export async function getEventById(id: number): Promise<Event | null> {
  const [rows] = await pool.query<Event[]>(
    "SELECT * FROM events WHERE id = ?",
    [id]
  );
  return rows.length > 0 ? rows[0] : null;
}
