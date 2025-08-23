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
exports.getAvailableRooms = getAvailableRooms;
exports.checkAvailability = checkAvailability;
exports.createReservation = createReservation;
exports.getReservationByNumber = getReservationByNumber;
exports.getUserReservations = getUserReservations;
exports.rescheduleReservation = rescheduleReservation;
exports.cancelReservation = cancelReservation;
exports.getReservationHistory = getReservationHistory;
const reservationModel = __importStar(require("../models/reservationModel"));
// Get available rooms
function getAvailableRooms(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const rooms = yield reservationModel.getAvailableRooms();
            // Format room names for better UX
            const roomNames = {
                "coding-zone": "Coding Zone",
                "meeting-room": "Meeting Room",
                "quiet-corner": "Quiet Corner",
                "open-space": "Open Space",
            };
            const formattedRooms = Object.keys(rooms).map((roomType) => {
                const tables = rooms[roomType];
                // Calculate average price for the room
                const totalPrice = tables.reduce((sum, table) => sum + table.price_per_hour, 0);
                const pricePerHour = tables.length > 0 ? totalPrice / tables.length : 0;
                return {
                    type: roomType,
                    name: roomNames[roomType],
                    description: getRoomDescription(roomType),
                    pricePerHour: pricePerHour, // Add pricePerHour to room
                    tables: tables.map((table) => (Object.assign(Object.assign({}, table), { formatted_price: formatPrice(table.price_per_hour) }))),
                };
            });
            return res.json({
                success: true,
                data: formattedRooms,
            });
        }
        catch (error) {
            console.error("Error fetching rooms:", error);
            return res.status(500).json({
                success: false,
                error: "Gagal mengambil data ruangan",
            });
        }
    });
}
// Check table availability
function checkAvailability(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { roomType, tableNumber, date, time, duration } = req.query;
        if (!roomType || !tableNumber || !date || !time) {
            return res.status(400).json({
                success: false,
                error: "Parameter tidak lengkap",
            });
        }
        try {
            const isAvailable = yield reservationModel.checkTableAvailability(roomType, tableNumber, date, time, parseInt(duration) || 2);
            // Get price for calculation
            const pricePerHour = yield reservationModel.getTablePrice(roomType, tableNumber);
            const totalPrice = pricePerHour * (parseInt(duration) || 2);
            return res.json({
                success: true,
                available: isAvailable,
                pricePerHour: pricePerHour,
                totalPrice: totalPrice,
                formattedPrice: formatPrice(totalPrice),
            });
        }
        catch (error) {
            console.error("Error checking availability:", error);
            return res.status(500).json({
                success: false,
                error: "Gagal memeriksa ketersediaan",
            });
        }
    });
}
// Create reservation
function createReservation(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a;
        const { customerName, email, phone, reservationDate, reservationTime, durationHours, roomType, tableNumber, guestCount, specialRequest, } = req.body;
        // Validation
        if (!customerName ||
            !email ||
            !phone ||
            !reservationDate ||
            !reservationTime ||
            !roomType ||
            !tableNumber) {
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
            const userId = ((_a = req.session) === null || _a === void 0 ? void 0 : _a.userId) || null;
            const reservationData = {
                userId,
                customerName,
                email,
                phone,
                reservationDate,
                reservationTime,
                durationHours: parseInt(durationHours) || 2,
                roomType,
                tableNumber: parseInt(tableNumber),
                guestCount: parseInt(guestCount) || 1,
                specialRequest,
            };
            const result = yield reservationModel.createReservation(reservationData);
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
        }
        catch (error) {
            console.error("Error creating reservation:", error);
            return res.status(500).json({
                success: false,
                error: error.message || "Gagal membuat reservasi",
            });
        }
    });
}
// Get reservation by number
function getReservationByNumber(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { reservationNumber } = req.params;
        try {
            const reservation = yield reservationModel.getReservationByNumber(reservationNumber);
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
        }
        catch (error) {
            console.error("Error fetching reservation:", error);
            return res.status(500).json({
                success: false,
                error: "Gagal mengambil data reservasi",
            });
        }
    });
}
// Get user reservations
function getUserReservations(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        var _a;
        if (!((_a = req.session) === null || _a === void 0 ? void 0 : _a.userId)) {
            return res.status(401).json({
                success: false,
                error: "Silakan login terlebih dahulu",
            });
        }
        try {
            const reservations = yield reservationModel.getUserReservations(req.session.userId);
            const formattedReservations = reservations.map((reservation) => formatReservationResponse(reservation));
            return res.json({
                success: true,
                data: formattedReservations,
            });
        }
        catch (error) {
            console.error("Error fetching user reservations:", error);
            return res.status(500).json({
                success: false,
                error: "Gagal mengambil data reservasi",
            });
        }
    });
}
// Reschedule reservation
function rescheduleReservation(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
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
            yield reservationModel.rescheduleReservation(parseInt(reservationId), newDate, newTime, parseInt(durationHours) || 2);
            return res.json({
                success: true,
                message: "Reservasi berhasil dijadwal ulang",
            });
        }
        catch (error) {
            console.error("Error rescheduling reservation:", error);
            return res.status(500).json({
                success: false,
                error: error.message || "Gagal menjadwal ulang reservasi",
            });
        }
    });
}
// Cancel reservation
function cancelReservation(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { reservationId } = req.params;
        const { reason } = req.body;
        try {
            yield reservationModel.cancelReservation(parseInt(reservationId), reason);
            return res.json({
                success: true,
                message: "Reservasi berhasil dibatalkan",
            });
        }
        catch (error) {
            console.error("Error cancelling reservation:", error);
            return res.status(500).json({
                success: false,
                error: error.message || "Gagal membatalkan reservasi",
            });
        }
    });
}
// Get reservation history
function getReservationHistory(req, res) {
    return __awaiter(this, void 0, void 0, function* () {
        const { reservationId } = req.params;
        try {
            const history = yield reservationModel.getReservationHistory(parseInt(reservationId));
            return res.json({
                success: true,
                data: history,
            });
        }
        catch (error) {
            console.error("Error fetching reservation history:", error);
            return res.status(500).json({
                success: false,
                error: "Gagal mengambil riwayat reservasi",
            });
        }
    });
}
// Helper functions
function getRoomDescription(roomType) {
    const descriptions = {
        "coding-zone": "Area khusus untuk coding dengan setup programming terbaik",
        "meeting-room": "Ruang meeting untuk diskusi tim dengan fasilitas presentasi",
        "quiet-corner": "Area tenang untuk fokus maksimal dan deep work",
        "open-space": "Area terbuka untuk networking dan collaborative work",
    };
    return descriptions[roomType] || "";
}
function formatReservationResponse(reservation) {
    const statusNames = {
        pending: "Menunggu Konfirmasi",
        confirmed: "Dikonfirmasi",
        completed: "Selesai",
        cancelled: "Dibatalkan",
        "no-show": "Tidak Hadir",
    };
    const roomNames = {
        "coding-zone": "Coding Zone",
        "meeting-room": "Meeting Room",
        "quiet-corner": "Quiet Corner",
        "open-space": "Open Space",
    };
    return Object.assign(Object.assign({}, reservation), { status_name: statusNames[reservation.status], room_name: roomNames[reservation.room_type], formatted_date: new Date(reservation.reservation_date).toLocaleDateString("id-ID"), formatted_time: reservation.reservation_time.substring(0, 5), end_time: calculateEndTime(reservation.reservation_time, reservation.duration_hours), formatted_price: formatPrice(reservation.total_price || 0) });
}
function calculateEndTime(startTime, durationHours) {
    const [hours, minutes] = startTime.split(":").map(Number);
    const endHours = hours + durationHours;
    const endTime = `${endHours.toString().padStart(2, "0")}:${minutes
        .toString()
        .padStart(2, "0")}`;
    return endTime;
}
function formatPrice(price) {
    return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
    }).format(price);
}
