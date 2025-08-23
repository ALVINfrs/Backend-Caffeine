import express from "express";
import * as orderController from "../controllers/orderController";
import { isAuthenticated } from "../middleware/auth";

const router = express.Router();

// Existing routes
router.post("/", orderController.createOrder);
router.get("/:id", orderController.getOrderById);
router.get("/user/orders", isAuthenticated, orderController.getUserOrders);

// New webhook route for Midtrans notifications
router.post("/webhook", orderController.handleMidtransWebhook);

router.put(
  "/:orderNumber/payment-update",
  isAuthenticated,
  orderController.updatePaymentMethod
);

export default router;
