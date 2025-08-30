import { Request, Response } from "express";
import { pool as db } from "./../../config/database";

// Helper function untuk menghitung persentase perubahan
function calculatePercentageChange(previous: number, current: number): number {
  if (previous === 0) {
    return current > 0 ? 100 : 0;
  }
  const prev = Number(previous) || 0;
  const curr = Number(current) || 0;
  return ((curr - prev) / prev) * 100;
}

// Fungsi untuk mendapatkan ringkasan data (Total Pendapatan, Pesanan, Pelanggan) dengan perbandingan
export const getDashboardSummary = async (req: Request, res: Response) => {
  try {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const sixtyDaysAgo = new Date();
    sixtyDaysAgo.setDate(sixtyDaysAgo.getDate() - 60);

    // Data 30 hari terakhir
    const [currentPeriodResult]: any = await db.query(
      `SELECT 
        SUM(CASE WHEN status IN ('completed', 'settlement') THEN total ELSE 0 END) as totalRevenue,
        COUNT(id) as totalOrders,
        COUNT(DISTINCT user_id) as newCustomers
      FROM orders WHERE order_date >= ?`,
      [thirtyDaysAgo]
    );

    // Data 30 hari sebelumnya (untuk perbandingan)
    const [previousPeriodResult]: any = await db.query(
      `SELECT 
        SUM(CASE WHEN status IN ('completed', 'settlement') THEN total ELSE 0 END) as totalRevenue,
        COUNT(id) as totalOrders,
        COUNT(DISTINCT user_id) as newCustomers
      FROM orders WHERE order_date >= ? AND order_date < ?`,
      [sixtyDaysAgo, thirtyDaysAgo]
    );

    // Total Pengguna
    const [usersResult]: any = await db.query(
      `SELECT COUNT(id) as totalUsers FROM users WHERE role = 'user'`
    );

    res.json({
      summary: {
        totalRevenue: currentPeriodResult[0].totalRevenue || 0,
        totalOrders: currentPeriodResult[0].totalOrders || 0,
        newCustomers: currentPeriodResult[0].newCustomers || 0,
        totalUsers: usersResult[0].totalUsers || 0,
      },
      comparison: {
        revenueChange: calculatePercentageChange(
          previousPeriodResult[0].totalRevenue,
          currentPeriodResult[0].totalRevenue
        ),
        ordersChange: calculatePercentageChange(
          previousPeriodResult[0].totalOrders,
          currentPeriodResult[0].totalOrders
        ),
        customersChange: calculatePercentageChange(
          previousPeriodResult[0].newCustomers,
          currentPeriodResult[0].newCustomers
        ),
      },
    });
  } catch (error) {
    console.error("Error fetching dashboard summary:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Fungsi untuk mendapatkan data grafik penjualan yang dinamis
export const getSalesChartData = async (req: Request, res: Response) => {
  const period = (req.query.period as string) || "weekly"; // weekly, monthly, yearly

  let query = "";

  switch (period) {
    case "monthly":
      query = `
        SELECT 
          DATE_FORMAT(order_date, '%Y-%m-01') as date,
          SUM(total) as totalSales
        FROM orders 
        WHERE status IN ('completed', 'settlement') AND order_date >= CURDATE() - INTERVAL 12 MONTH
        GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
        ORDER BY date ASC
      `;
      break;
    case "yearly":
      query = `
        SELECT 
          DATE_FORMAT(order_date, '%Y-01-01') as date,
          SUM(total) as totalSales
        FROM orders 
        WHERE status IN ('completed', 'settlement')
        GROUP BY DATE_FORMAT(order_date, '%Y-01-01')
        ORDER BY date ASC
      `;
      break;
    case "weekly":
    default:
      query = `
        SELECT 
          DATE(order_date) as date,
          SUM(total) as totalSales
        FROM orders 
        WHERE status IN ('completed', 'settlement') AND order_date >= CURDATE() - INTERVAL 7 DAY
        GROUP BY DATE(order_date)
        ORDER BY date ASC
      `;
      break;
  }

  try {
    const [salesData] = await db.query(query);
    res.json(salesData);
  } catch (error) {
    console.error("Error fetching sales chart data:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Fungsi untuk mendapatkan produk terlaris
export const getTopSellingProducts = async (req: Request, res: Response) => {
  try {
    const [topProducts]: any = await db.query(`
            SELECT p.name, SUM(oi.quantity) as totalQuantity
            FROM order_items oi
            JOIN products p ON oi.product_id = p.id
            GROUP BY p.name
            ORDER BY totalQuantity DESC
            LIMIT 5
        `);
    res.json(topProducts);
  } catch (error) {
    console.error("Error fetching top selling products:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Fungsi untuk mendapatkan pesanan terbaru
export const getRecentOrders = async (req: Request, res: Response) => {
  try {
    const [recentOrders]: any = await db.query(`
            SELECT id, order_number, customer_name, total, status, order_date
            FROM orders
            ORDER BY order_date DESC
            LIMIT 5
        `);
    res.json(recentOrders);
  } catch (error) {
    console.error("Error fetching recent orders:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};

// Fungsi untuk mendapatkan analitik kategori terlaris
export const getTopCategories = async (req: Request, res: Response) => {
  try {
    const [topCategories]: any = await db.query(`
            SELECT p.category, SUM(oi.subtotal) as totalRevenue
            FROM order_items oi
            JOIN products p ON oi.product_id = p.id
            JOIN orders o ON oi.order_id = o.id
            WHERE o.status IN ('completed', 'settlement')
            GROUP BY p.category
            ORDER BY totalRevenue DESC
            LIMIT 5
        `);
    res.json(topCategories);
  } catch (error) {
    console.error("Error fetching top categories:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};
