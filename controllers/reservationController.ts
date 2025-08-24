import { Request, Response } from "express";
import * as reservationModel from "../models/reservationModel";

interface Table {
  table_number: number;
  price_per_hour: number;
  formatted_price: string;
}

interface Room {
  type: string;
  name: string;
  description: string;
  pricePerHour: number;
  tables: Table[];
}

// Get available rooms
async function getAvailableRooms(
  req: Request,
  res: Response
): Promise<Response> {
  try {
    const rooms = await reservationModel.getAvailableRooms();

    // Format room names for better UX
    const roomNames: { [key: string]: string } = {
      "coding-zone": "Coding Zone",
      "meeting-room": "Meeting Room",
      "quiet-corner": "Quiet Corner",
      "open-space": "Open Space",
    };

    const formattedRooms: Room[] = Object.keys(rooms).map((roomType) => {
      const tables = rooms[roomType];
      // Calculate average price for the room
      const totalPrice = tables.reduce(
        (sum: number, table: any) => sum + table.price_per_hour,
        0
      );
      const pricePerHour = tables.length > 0 ? totalPrice / tables.length : 0;

      return {
        type: roomType,
        name: roomNames[roomType],
        description: getRoomDescription(roomType),
        pricePerHour: pricePerHour, // Add pricePerHour to room
        tables: tables.map((table: any) => ({
          ...table,
          formatted_price: formatPrice(table.price_per_hour),
        })),
      };
    });

    return res.json({
      success: true,
      data: formattedRooms,
    });
  } catch (error: any) {
    console.error("Error fetching rooms:", error);
    return res.status(500).json({
      success: false,
      error: "Gagal mengambil data ruangan",
    });
  }
}

// Check table availability
async function checkAvailability(
  req: Request,
  res: Response
): Promise<Response> {
  const { roomType, tableNumber, date, time, duration } = req.query;

  if (!roomType || !tableNumber || !date || !time) {
    return res.status(400).json({
      success: false,
      error: "Parameter tidak lengkap",
    });
  }

  try {
    const isAvailable = await reservationModel.checkTableAvailability(
      roomType as string,
      tableNumber as string,
      date as string,
      time as string,
      parseInt(duration as string) || 2
    );

    // Get price for calculation
    const pricePerHour = await reservationModel.getTablePrice(
      roomType as string,
      tableNumber as string
    );
    const totalPrice = pricePerHour * (parseInt(duration as string) || 2);

    return res.json({
      success: true,
      available: isAvailable,
      pricePerHour: pricePerHour,
      totalPrice: totalPrice,
      formattedPrice: formatPrice(totalPrice),
    });
  } catch (error: any) {
    console.error("Error checking availability:", error);
    return res.status(500).json({
      success: false,
      error: "Gagal memeriksa ketersediaan",
    });
  }
}

interface CreateReservationBody {
  customerName: string;
  email: string;
  phone: string;
  reservationDate: string;
  reservationTime: string;
  durationHours: string;
  roomType: string;
  tableNumber: string;
  guestCount: string;
  specialRequest: string;
}

// Create reservation
async function createReservation(
  req: Request,
  res: Response
): Promise<Response> {
  const {
    customerName,
    email,
    phone,
    reservationDate,
    reservationTime,
    durationHours,
    roomType,
    tableNumber,
    guestCount,
    specialRequest,
  }: CreateReservationBody = req.body;

  // Validation
  if (
    !customerName ||
    !email ||
    !phone ||
    !reservationDate ||
    !reservationTime ||
    !roomType ||
    !tableNumber
  ) {
    return res.status(400).json({
      success: false,
      error: "Data tidak lengkap",
    });
  }

  // Check if reservation date is not in the past
  const now = new Date();
  const reservationDateTime = new Date(`${reservationDate} ${reservationTime}`);

  if (reservationDateTime < now) {
    return res.status(400).json({
      success: false,
      error: "Tidak dapat membuat reservasi untuk waktu yang sudah berlalu",
    });
  }

  try {
    const userId = req.session?.userId || null;

    const numericPart = tableNumber.match(/\d+/);
    const parsedTableNumber = numericPart ? parseInt(numericPart[0], 10) : NaN;
    if (isNaN(parsedTableNumber)) {
      return res.status(400).json({
        success: false,
        error: "Nomor meja tidak valid",
      });
    }

    const reservationData = {
      userId,
      customerName,
      email,
      phone,
      reservationDate,
      reservationTime,
      durationHours: parseInt(durationHours, 10) || 2,
      roomType,
      tableNumber: parsedTableNumber,
      guestCount: parseInt(guestCount, 10) || 1,
      specialRequest,
    };

    const result = await reservationModel.createReservation(reservationData);

    return res.status(201).json({
      success: true,
      message: "Reservasi berhasil dibuat",
      data: {
        reservationId: result.reservationId,
        reservationNumber: result.reservationNumber,
        totalPrice: result.totalPrice,
        formattedPrice: formatPrice(result.totalPrice),
      },
    });
  } catch (error: any) {
    console.error("Error creating reservation:", error);
    return res.status(500).json({
      success: false,
      error: error.message || "Gagal membuat reservasi",
    });
  }
}

// Get reservation by number
async function getReservationByNumber(
  req: Request,
  res: Response
): Promise<Response> {
  const { reservationNumber } = req.params;

  try {
    const reservation = await reservationModel.getReservationByNumber(
      reservationNumber
    );

    if (!reservation) {
      return res.status(404).json({
        success: false,
        error: "Reservasi tidak ditemukan",
      });
    }

    // Format response
    const formattedReservation = formatReservationResponse(reservation);

    return res.json({
      success: true,
      data: formattedReservation,
    });
  } catch (error: any) {
    console.error("Error fetching reservation:", error);
    return res.status(500).json({
      success: false,
      error: "Gagal mengambil data reservasi",
    });
  }
}

// Get user reservations
async function getUserReservations(
  req: Request,
  res: Response
): Promise<Response> {
  if (!req.session?.userId) {
    return res.status(401).json({
      success: false,
      error: "Silakan login terlebih dahulu",
    });
  }

  try {
    const reservations = await reservationModel.getUserReservations(
      req.session.userId
    );

    const formattedReservations = reservations.map((reservation: any) =>
      formatReservationResponse(reservation)
    );

    return res.json({
      success: true,
      data: formattedReservations,
    });
  } catch (error: any) {
    console.error("Error fetching user reservations:", error);
    return res.status(500).json({
      success: false,
      error: "Gagal mengambil data reservasi",
    });
  }
}

// Reschedule reservation
async function rescheduleReservation(
  req: Request,
  res: Response
): Promise<Response> {
  const { reservationId } = req.params;
  const { newDate, newTime, durationHours } = req.body;

  if (!newDate || !newTime) {
    return res.status(400).json({
      success: false,
      error: "Tanggal dan waktu baru harus diisi",
    });
  }

  // Check if new date is not in the past
  const now = new Date();
  const newDateTime = new Date(`${newDate} ${newTime}`);

  if (newDateTime < now) {
    return res.status(400).json({
      success: false,
      error: "Tidak dapat menjadwal ulang untuk waktu yang sudah berlalu",
    });
  }

  try {
    await reservationModel.rescheduleReservation(
      parseInt(reservationId),
      newDate,
      newTime,
      parseInt(durationHours) || 2
    );

    return res.json({
      success: true,
      message: "Reservasi berhasil dijadwal ulang",
    });
  } catch (error: any) {
    console.error("Error rescheduling reservation:", error);
    return res.status(500).json({
      success: false,
      error: error.message || "Gagal menjadwal ulang reservasi",
    });
  }
}

// Cancel reservation
async function cancelReservation(
  req: Request,
  res: Response
): Promise<Response> {
  const { reservationId } = req.params;
  const { reason } = req.body;

  try {
    await reservationModel.cancelReservation(parseInt(reservationId), reason);

    return res.json({
      success: true,
      message: "Reservasi berhasil dibatalkan",
    });
  } catch (error: any) {
    console.error("Error cancelling reservation:", error);
    return res.status(500).json({
      success: false,
      error: error.message || "Gagal membatalkan reservasi",
    });
  }
}

// Get reservation history
async function getReservationHistory(
  req: Request,
  res: Response
): Promise<Response> {
  const { reservationId } = req.params;

  try {
    const history = await reservationModel.getReservationHistory(
      parseInt(reservationId)
    );

    return res.json({
      success: true,
      data: history,
    });
  } catch (error: any) {
    console.error("Error fetching reservation history:", error);
    return res.status(500).json({
      success: false,
      error: "Gagal mengambil riwayat reservasi",
    });
  }
}

// Helper functions
function getRoomDescription(roomType: string): string {
  const descriptions: { [key: string]: string } = {
    "coding-zone": "Area khusus untuk coding dengan setup programming terbaik",
    "meeting-room":
      "Ruang meeting untuk diskusi tim dengan fasilitas presentasi",
    "quiet-corner": "Area tenang untuk fokus maksimal dan deep work",
    "open-space": "Area terbuka untuk networking dan collaborative work",
  };

  return descriptions[roomType] || "";
}

function formatReservationResponse(reservation: any): any {
  const statusNames: { [key: string]: string } = {
    pending: "Menunggu Konfirmasi",
    confirmed: "Dikonfirmasi",
    completed: "Selesai",
    cancelled: "Dibatalkan",
    "no-show": "Tidak Hadir",
  };

  const roomNames: { [key: string]: string } = {
    "coding-zone": "Coding Zone",
    "meeting-room": "Meeting Room",
    "quiet-corner": "Quiet Corner",
    "open-space": "Open Space",
  };

  return {
    ...reservation,
    status_name: statusNames[reservation.status],
    room_name: roomNames[reservation.room_type],
    formatted_date: new Date(reservation.reservation_date).toLocaleDateString(
      "id-ID"
    ),
    formatted_time: reservation.reservation_time.substring(0, 5),
    end_time: calculateEndTime(
      reservation.reservation_time,
      reservation.duration_hours
    ),
    formatted_price: formatPrice(reservation.total_price || 0),
  };
}

function calculateEndTime(startTime: string, durationHours: number): string {
  const [hours, minutes] = startTime.split(":").map(Number);
  const endHours = hours + durationHours;
  const endTime = `${endHours.toString().padStart(2, "0")}:${minutes
    .toString()
    .padStart(2, "0")}`;
  return endTime;
}

function formatPrice(price: number): string {
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
    minimumFractionDigits: 0,
  }).format(price);
}

export {
  getAvailableRooms,
  checkAvailability,
  createReservation,
  getReservationByNumber,
  getUserReservations,
  rescheduleReservation,
  cancelReservation,
  getReservationHistory,
};
