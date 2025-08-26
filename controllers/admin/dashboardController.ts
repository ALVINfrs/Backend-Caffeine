import { Request, Response } from 'express';
import db from '../../config/database';

// Fungsi untuk mendapatkan ringkasan data (Total Pendapatan, Pesanan, Pelanggan)
export const getDashboardSummary = async (req: Request, res: Response) => {
  try {
    // Implementasi query untuk total pendapatan (hanya dari order yang selesai)
    const [revenueResult]: any = await db.query(
      `SELECT SUM(total) as totalRevenue FROM orders WHERE status IN ('completed', 'settlement')`
    );

    // Implementasi query untuk total pesanan
    const [ordersResult]: any = await db.query(
      `SELECT COUNT(id) as totalOrders FROM orders`
    );

    // Implementasi query untuk total pelanggan
    const [usersResult]: any = await db.query(
      `SELECT COUNT(id) as totalUsers FROM users WHERE role = 'user'`
    );

    res.json({
      totalRevenue: revenueResult[0].totalRevenue || 0,
      totalOrders: ordersResult[0].totalOrders || 0,
      totalUsers: usersResult[0].totalUsers || 0,
    });
  } catch (error) {
    console.error('Error fetching dashboard summary:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

// Fungsi untuk mendapatkan data grafik penjualan (misal: 7 hari terakhir)
export const getSalesChartData = async (req: Request, res: Response) => {
  try {
    const [salesData]: any = await db.query(`
      SELECT 
        DATE(order_date) as date,
        SUM(total) as totalSales
      FROM orders 
      WHERE status IN ('completed', 'settlement') AND order_date >= CURDATE() - INTERVAL 7 DAY
      GROUP BY DATE(order_date)
      ORDER BY date ASC
    `);

    res.json(salesData);
  } catch (error) {
    console.error('Error fetching sales chart data:', error);
    res.status(500).json({ message: 'Internal Server Error' });
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
        console.error('Error fetching top selling products:', error);
        res.status(500).json({ message: 'Internal Server Error' });
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
        console.error('Error fetching recent orders:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
};
