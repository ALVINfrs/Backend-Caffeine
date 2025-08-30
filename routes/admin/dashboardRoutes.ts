import { Router } from "express";
import {
  getDashboardSummary,
  getSalesChartData,
  getTopSellingProducts,
  getRecentOrders,
  getTopCategories, // Impor fungsi baru
} from "../../controllers/admin/dashboardController";
import { isAdmin } from "../../middleware/admin/auth";

const router = Router();

// Semua rute di sini akan dilindungi oleh middleware isAdmin
router.use(isAdmin);

router.get("/summary", getDashboardSummary);
router.get("/sales-chart", getSalesChartData);
router.get("/top-products", getTopSellingProducts);
router.get("/recent-orders", getRecentOrders);
router.get("/top-categories", getTopCategories); // Tambahkan rute baru

export default router;
