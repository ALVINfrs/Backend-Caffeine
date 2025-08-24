"use strict";
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
exports.checkTableAvailability = checkTableAvailability;
exports.getTablePrice = getTablePrice;
exports.createReservation = createReservation;
exports.getReservationById = getReservationById;
exports.getReservationByNumber = getReservationByNumber;
exports.getUserReservations = getUserReservations;
exports.rescheduleReservation = rescheduleReservation;
exports.cancelReservation = cancelReservation;
exports.updateReservationStatus = updateReservationStatus;
exports.getReservationHistory = getReservationHistory;
const database_1 = require("../config/database");
// Get available rooms and tables
function getAvailableRooms() {
    return __awaiter(this, void 0, void 0, function* () {
        const [rooms] = yield database_1.pool.query(`
    SELECT room_type, table_number, capacity, description, price_per_hour
    FROM room_tables
    WHERE is_available = 1
    ORDER BY room_type, table_number
  `);
        // Group by room type
        const roomsByType = rooms.reduce((acc, room) => {
            if (!acc[room.room_type]) {
                acc[room.room_type] = [];
            }
            acc[room.room_type].push(room);
            return acc;
        }, {});
        return roomsByType;
    });
}
// Check table availability for specific date and time
function checkTableAvailability(roomType_1, tableNumber_1, date_1, time_1, durationHours_1) {
    return __awaiter(this, arguments, void 0, function* (roomType, tableNumber, date, time, durationHours, excludeReservationId = null) {
        let query = `
    SELECT COUNT(*) as conflict_count
    FROM reservations
    WHERE room_type = ?
    AND table_number = ?
    AND reservation_date = ?
    AND status NOT IN ('cancelled', 'no-show')
    AND (
      (reservation_time <= ? AND DATE_ADD(CONCAT(reservation_date, ' ', reservation_time), INTERVAL duration_hours HOUR) > ?)
      OR
      (? <= reservation_time AND ? > reservation_time)
    )
  `;
        const params = [
            roomType,
            tableNumber,
            date,
            time,
            `${date} ${time}`,
            time,
            `${date} ${time}`,
        ];
        if (excludeReservationId) {
            query += ` AND id != ?`;
            params.push(excludeReservationId);
        }
        const [result] = yield database_1.pool.query(query, params);
        return result[0].conflict_count === 0;
    });
}
// Get table price
function getTablePrice(roomType, tableNumber) {
    return __awaiter(this, void 0, void 0, function* () {
        const [result] = yield database_1.pool.query("SELECT price_per_hour FROM room_tables WHERE room_type = ? AND table_number = ?", [roomType, tableNumber]);
        return result.length > 0 ? result[0].price_per_hour : 0;
    });
}
// Create new reservation
function createReservation(reservationData) {
    return __awaiter(this, void 0, void 0, function* () {
        const connection = yield database_1.pool.getConnection();
        yield connection.beginTransaction();
        try {
            const { userId, customerName, email, phone, reservationDate, reservationTime, durationHours, roomType, tableNumber, guestCount, specialRequest, } = reservationData;
            // Check availability
            const isAvailable = yield checkTableAvailability(roomType, tableNumber.toString(), reservationDate, reservationTime, durationHours);
            if (!isAvailable) {
                throw new Error("Meja tidak tersedia untuk waktu yang dipilih");
            }
            // Get price per hour
            const pricePerHour = yield getTablePrice(roomType, tableNumber.toString());
            const totalPrice = pricePerHour * durationHours;
            const parsedDurationHours = Number(durationHours);
            const parsedTableNumber = Number(tableNumber);
            const parsedGuestCount = Number(guestCount);
            const parsedPricePerHour = Number(pricePerHour);
            const parsedTotalPrice = Number(totalPrice);
            // Validasi nilai
            if (isNaN(parsedTableNumber)) {
                throw new Error("Invalid table number. Please provide a valid number.");
            }
            // Create reservation
            const [result] = yield connection.query(`
      INSERT INTO reservations
      (user_id, customer_name, email, phone, reservation_date, reservation_time,
       duration_hours, room_type, table_number, guest_count, special_request,
       price_per_hour, total_price, status)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'confirmed')
    `, [
                userId,
                customerName,
                email,
                phone,
                reservationDate,
                reservationTime,
                parsedDurationHours,
                roomType,
                parsedTableNumber,
                parsedGuestCount,
                specialRequest,
                parsedPricePerHour,
                parsedTotalPrice,
            ]);
            const reservationId = result.insertId;
            // Generate reservation number
            const reservationNumber = `RES-${reservationId}-${Date.now()
                .toString()
                .slice(-6)}`;
            // Update with reservation number
            yield connection.query("UPDATE reservations SET reservation_number = ? WHERE id = ?", [reservationNumber, reservationId]);
            // Add to history
            yield connection.query(`
      INSERT INTO reservation_history
      (reservation_id, action, new_date, new_time, notes)
      VALUES (?, 'created', ?, ?, 'Reservasi dibuat')
    `, [reservationId, reservationDate, reservationTime]);
            yield connection.commit();
            return {
                reservationId,
                reservationNumber,
                totalPrice,
            };
        }
        catch (error) {
            yield connection.rollback();
            throw error;
        }
        finally {
            connection.release();
        }
    });
}
// Get reservation by ID
function getReservationById(reservationId) {
    return __awaiter(this, void 0, void 0, function* () {
        const [reservations] = yield database_1.pool.query(`
    SELECT r.*, rt.description as table_description, rt.capacity as table_capacity
    FROM reservations r
    LEFT JOIN room_tables rt ON r.room_type = rt.room_type AND r.table_number = rt.table_number
    WHERE r.id = ?
  `, [reservationId]);
        if (reservations.length === 0) {
            return null;
        }
        return reservations[0];
    });
}
// Get reservation by reservation number
function getReservationByNumber(reservationNumber) {
    return __awaiter(this, void 0, void 0, function* () {
        const [reservations] = yield database_1.pool.query(`
    SELECT r.*, rt.description as table_description, rt.capacity as table_capacity
    FROM reservations r
    LEFT JOIN room_tables rt ON r.room_type = rt.room_type AND r.table_number = rt.table_number
    WHERE r.reservation_number = ?
  `, [reservationNumber]);
        if (reservations.length === 0) {
            return null;
        }
        return reservations[0];
    });
}
// Get user reservations
function getUserReservations(userId) {
    return __awaiter(this, void 0, void 0, function* () {
        const [reservations] = yield database_1.pool.query(`
    SELECT r.*, rt.description as table_description, rt.capacity as table_capacity
    FROM reservations r
    LEFT JOIN room_tables rt ON r.room_type = rt.room_type AND r.table_number = rt.table_number
    WHERE r.user_id = ?
    ORDER BY r.reservation_date DESC, r.reservation_time DESC
  `, [userId]);
        return reservations;
    });
}
// Reschedule reservation
function rescheduleReservation(reservationId, newDate, newTime, durationHours) {
    return __awaiter(this, void 0, void 0, function* () {
        const connection = yield database_1.pool.getConnection();
        yield connection.beginTransaction();
        try {
            // Get current reservation
            const [current] = yield connection.query("SELECT * FROM reservations WHERE id = ?", [reservationId]);
            if (current.length === 0) {
                throw new Error("Reservasi tidak ditemukan");
            }
            const reservation = current[0];
            // Check if can be rescheduled (only pending or confirmed)
            if (!["pending", "confirmed"].includes(reservation.status)) {
                throw new Error("Reservasi tidak dapat dijadwal ulang");
            }
            // Check new slot availability
            const isAvailable = yield checkTableAvailability(reservation.room_type, reservation.table_number.toString(), newDate, newTime, durationHours, reservationId);
            if (!isAvailable) {
                throw new Error("Waktu baru tidak tersedia");
            }
            // Recalculate price if duration changed
            const pricePerHour = yield getTablePrice(reservation.room_type, reservation.table_number.toString());
            const newTotalPrice = pricePerHour * durationHours;
            const oldDate = reservation.reservation_date;
            const oldTime = reservation.reservation_time;
            // Update reservation
            yield connection.query(`
      UPDATE reservations
      SET reservation_date = ?, reservation_time = ?, duration_hours = ?,
          total_price = ?, updated_at = NOW()
      WHERE id = ?
    `, [newDate, newTime, durationHours, newTotalPrice, reservationId]);
            // Add to history
            yield connection.query(`
      INSERT INTO reservation_history
      (reservation_id, action, old_date, old_time, new_date, new_time, notes)
      VALUES (?, 'rescheduled', ?, ?, ?, ?, 'Reservasi dijadwal ulang')
    `, [reservationId, oldDate, oldTime, newDate, newTime]);
            yield connection.commit();
            return true;
        }
        catch (error) {
            yield connection.rollback();
            throw error;
        }
        finally {
            connection.release();
        }
    });
}
// Cancel reservation
function cancelReservation(reservationId_1) {
    return __awaiter(this, arguments, void 0, function* (reservationId, reason = null) {
        const connection = yield database_1.pool.getConnection();
        yield connection.beginTransaction();
        try {
            // Get current reservation
            const [current] = yield connection.query("SELECT * FROM reservations WHERE id = ?", [reservationId]);
            if (current.length === 0) {
                throw new Error("Reservasi tidak ditemukan");
            }
            const reservation = current[0];
            // Check if can be cancelled
            if (["completed", "cancelled"].includes(reservation.status)) {
                throw new Error("Reservasi tidak dapat dibatalkan");
            }
            // Update status
            yield connection.query(`
      UPDATE reservations
      SET status = 'cancelled', updated_at = NOW()
      WHERE id = ?
    `, [reservationId]);
            // Add to history
            yield connection.query(`
      INSERT INTO reservation_history
      (reservation_id, action, notes)
      VALUES (?, 'cancelled', ?)
    `, [reservationId, reason || "Reservasi dibatalkan oleh user"]);
            yield connection.commit();
            return true;
        }
        catch (error) {
            yield connection.rollback();
            throw error;
        }
        finally {
            connection.release();
        }
    });
}
// Update reservation status
function updateReservationStatus(reservationId, status) {
    return __awaiter(this, void 0, void 0, function* () {
        yield database_1.pool.query(`
    UPDATE reservations
    SET status = ?, updated_at = NOW()
    WHERE id = ?
  `, [status, reservationId]);
        // Add to history
        yield database_1.pool.query(`
    INSERT INTO reservation_history
    (reservation_id, action, notes)
    VALUES (?, ?, ?)
  `, [reservationId, status, `Status diubah menjadi ${status}`]);
    });
}
// Get reservation history
function getReservationHistory(reservationId) {
    return __awaiter(this, void 0, void 0, function* () {
        const [history] = yield database_1.pool.query(`
    SELECT * FROM reservation_history
    WHERE reservation_id = ?
    ORDER BY created_at DESC
  `, [reservationId]);
        return history;
    });
}
