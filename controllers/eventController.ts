import { Request, Response } from "express";
import * as eventModel from "../models/eventModel";

export async function getAllActiveEvents(
  req: Request,
  res: Response
): Promise<Response> {
  try {
    const events = await eventModel.getActiveEvents();
    return res.json({ success: true, data: events });
  } catch (error: any) {
    console.error("Error fetching active events:", error);
    return res
      .status(500)
      .json({ success: false, error: "Gagal mengambil data event" });
  }
}

export async function getEventDetails(
  req: Request,
  res: Response
): Promise<Response> {
  try {
    const id = parseInt(req.params.id, 10);
    const event = await eventModel.getEventById(id);
    if (!event) {
      return res
        .status(404)
        .json({ success: false, error: "Event tidak ditemukan" });
    }
    return res.json({ success: true, data: event });
  } catch (error: any) {
    console.error("Error fetching event details:", error);
    return res
      .status(500)
      .json({ success: false, error: "Gagal mengambil detail event" });
  }
}
