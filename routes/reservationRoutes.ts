import express from "express";
import * as reservationController from "../controllers/reservationController";

const router = express.Router();

// Public routes
router.get("/rooms", reservationController.getAvailableRooms);
router.get("/check-availability", reservationController.checkAvailability);
router.post("/create", reservationController.createReservation);
router.get("/:reservationNumber", reservationController.getReservationByNumber);

// Protected routes (require login)
router.get("/user/my-reservations", reservationController.getUserReservations);
router.put(
  "/:reservationId/reschedule",
  reservationController.rescheduleReservation
);
router.put("/:reservationId/cancel", reservationController.cancelReservation);
router.get(
  "/:reservationId/history",
  reservationController.getReservationHistory
);

export default router;

