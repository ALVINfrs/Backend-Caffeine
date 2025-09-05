import { Request, Response } from "express";
import { pool as db } from "./../../config/database";
import { ResultSetHeader } from "mysql2";

// Mendapatkan semua event dengan paginasi
export const getAllEvents = async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string) || 1;
  const limit = parseInt(req.query.limit as string) || 10;
  const offset = (page - 1) * limit;

  try {
    const [events] = await db.query(
      "SELECT * FROM events ORDER BY date DESC, time DESC LIMIT ? OFFSET ?",
      [limit, offset]
    );
    const [[{ total }]]: any = await db.query(
      "SELECT COUNT(*) as total FROM events"
    );

    res.json({
      data: events,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Membuat event baru
export const createEvent = async (req: Request, res: Response) => {
  const { title, description, speaker, date, time, type, is_active } = req.body;
  const image = req.file
    ? `/img/events/${req.file.filename}`
    : "/img/events/default.png";

  try {
    const [result] = await db.query<ResultSetHeader>(
      "INSERT INTO events (title, description, image, speaker, date, time, type, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [title, description, image, speaker, date, time, type, is_active || 1]
    );
    res.status(201).json({ id: result.insertId, ...req.body, image });
  } catch (error) {
    console.error("Error creating event:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Memperbarui event
export const updateEvent = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { title, description, speaker, date, time, type, is_active } = req.body;

  try {
    const [event]: any = await db.query(
      "SELECT image FROM events WHERE id = ?",
      [id]
    );
    if (event.length === 0) {
      return res.status(404).json({ message: "Event tidak ditemukan" });
    }

    const image = req.file
      ? `/img/events/${req.file.filename}`
      : event[0].image;

    await db.query(
      "UPDATE events SET title = ?, description = ?, image = ?, speaker = ?, date = ?, time = ?, type = ?, is_active = ? WHERE id = ?",
      [title, description, image, speaker, date, time, type, is_active, id]
    );
    res.json({ message: "Event berhasil diperbarui" });
  } catch (error) {
    console.error("Error updating event:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Menghapus event
export const deleteEvent = async (req: Request, res: Response) => {
  try {
    const [result]: any = await db.query("DELETE FROM events WHERE id = ?", [
      req.params.id,
    ]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Event tidak ditemukan" });
    }
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ message: "Internal Server Error" });
  }
};
