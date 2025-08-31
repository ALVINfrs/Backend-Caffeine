import { Request, Response } from "express";
import { pool } from "../config/database";
import { RowDataPacket } from "mysql2";

interface Product extends RowDataPacket {
  id: number;
  name: string;
  // ... properti produk lainnya
}

interface Recommendation<T> {
  title: string;
  message?: string;
  type: "product" | "reservation";
  items: T[];
}

/**
 * Controller utama untuk sistem rekomendasi cerdas.
 * Memberikan berbagai jenis rekomendasi produk dan reservasi
 * yang terpersonalisasi dalam satu panggilan API.
 */
export const getCombinedRecommendations = async (
  req: Request,
  res: Response
): Promise<Response> => {
  const userId = req.session?.userId;

  if (!userId) {
    return res.status(401).json({ error: "Unauthorized" });
  }

  try {
    // Jalankan semua fungsi analitik secara paralel untuk efisiensi
    const [collaborativeProducts, contextualProducts, reservationSuggestions] =
      await Promise.all([
        getCollaborativeFilteringProducts(userId),
        getContextualProductsForReservation(userId),
        getReservationSuggestions(userId),
      ]);

    // Gabungkan semua hasil rekomendasi yang tidak null
    const recommendations = [
      collaborativeProducts,
      contextualProducts,
      reservationSuggestions,
    ].filter((rec) => rec !== null);

    return res.json({
      success: true,
      recommendations,
    });
  } catch (error) {
    console.error("Error generating combined recommendations:", error);
    return res
      .status(500)
      .json({ message: "Gagal memuat rekomendasi cerdas." });
  }
};

/**
 * STRATEGI 1: COLLABORATIVE FILTERING
 * Menemukan produk berdasarkan "Pelanggan seperti Anda juga membeli..."
 */
async function getCollaborativeFilteringProducts(
  userId: number
): Promise<Recommendation<Product> | null> {
  // 1. Temukan 3 produk favorit pengguna (paling sering dibeli)
  const [favProducts]: any = await pool.query(
    `SELECT product_id FROM order_items oi
         JOIN orders o ON oi.order_id = o.id
         WHERE o.user_id = ? AND o.status IN ('completed', 'settlement')
         GROUP BY product_id ORDER BY COUNT(product_id) DESC LIMIT 3`,
    [userId]
  );

  if (favProducts.length === 0) return null; // Belum ada data untuk dianalisis
  const favProductIds = favProducts.map(
    (p: { product_id: number }) => p.product_id
  );

  // 2. Temukan 10 pengguna lain yang juga membeli produk favorit tersebut
  const [similarUsers]: any = await pool.query(
    `SELECT DISTINCT o.user_id FROM orders o
         JOIN order_items oi ON o.order_id = oi.id
         WHERE o.user_id != ? AND oi.product_id IN (?) AND o.status IN ('completed', 'settlement')
         LIMIT 10`,
    [userId, favProductIds]
  );

  if (similarUsers.length === 0) return null;
  const similarUserIds = similarUsers.map(
    (u: { user_id: number }) => u.user_id
  );

  // 3. Temukan produk populer lain yang dibeli oleh pengguna-pengguna tersebut,
  //    dan kecualikan produk yang sudah pernah dibeli oleh pengguna saat ini.
  const [recommendedProducts] = await pool.query<Product[]>(
    `SELECT p.*, COUNT(oi.product_id) as popularity 
         FROM products p
         JOIN order_items oi ON p.id = oi.product_id
         JOIN orders o ON oi.order_id = o.id
         WHERE o.user_id IN (?) AND p.id NOT IN (?)
         GROUP BY p.id 
         ORDER BY popularity DESC 
         LIMIT 5`,
    [similarUserIds, favProductIds]
  );

  if (recommendedProducts.length === 0) return null;

  return {
    title: "Pelanggan seperti Anda juga membeli",
    type: "product",
    items: recommendedProducts,
  };
}

/**
 * STRATEGI 2: KONTEKSTUAL PRODUK
 * Menawarkan produk yang relevan dengan reservasi yang akan datang.
 */
async function getContextualProductsForReservation(
  userId: number
): Promise<Recommendation<Product> | null> {
  const [futureReservations]: any = await pool.query(
    `SELECT room_type, DATE_FORMAT(reservation_date, '%W, %d %M %Y') as formatted_date 
         FROM reservations 
         WHERE user_id = ? AND reservation_date BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY AND status = 'confirmed'
         ORDER BY reservation_date ASC LIMIT 1`,
    [userId]
  );

  if (futureReservations.length === 0) return null;

  const { room_type, formatted_date } = futureReservations[0];
  let category = "snack";
  let message = `Untuk sesi Anda di ${room_type} pada ${formatted_date}`;

  if (room_type === "meeting-room") {
    category = "coffee";
    message = `Butuh penyemangat untuk rapat Anda di ${room_type}?`;
  }
  if (room_type === "coding-zone") {
    category = "main-course";
    message = `Isi tenaga untuk sesi coding Anda di ${room_type}`;
  }

  const [products] = await pool.query<Product[]>(
    `SELECT * FROM products WHERE category = ? ORDER BY RAND() LIMIT 3`,
    [category]
  );

  return {
    title: "Sempurna untuk Kunjungan Anda Berikutnya",
    message,
    type: "product",
    items: products,
  };
}

/**
 * STRATEGI 3: REKOMENDASI RESERVASI
 * Menganalisis kebiasaan pengguna untuk menyarankan reservasi.
 */
interface RoomTable extends RowDataPacket {
  id: number;
  room_type: string;
  // Add other room table fields as needed
}

async function getReservationSuggestions(
  userId: number
): Promise<Recommendation<any> | null> {
  // Analisis pesanan grup (jika sering pesan > 2 item berbeda dalam 1 order)
  const [groupOrders]: any = await pool.query(
    `SELECT COUNT(*) as total FROM (
            SELECT o.id FROM orders o
            JOIN order_items oi ON o.id = oi.order_id
            WHERE o.user_id = ? AND o.status IN ('completed', 'settlement')
            GROUP BY o.id
            HAVING COUNT(DISTINCT oi.product_id) > 2
        ) as group_orders`,
    [userId]
  );

  if (groupOrders[0].total > 2) {
    // Fix first error by adding proper typing
    const [meetingRoom] = await pool.query<RoomTable[]>(
      `SELECT * FROM room_tables WHERE room_type = 'meeting-room' LIMIT 1`
    );

    return {
      title: "Datang Bersama Tim?",
      message:
        "Sepertinya Anda sering datang bersama rekan. Pesan Meeting Room untuk pengalaman yang lebih nyaman!",
      type: "reservation",
      items: meetingRoom,
    };
  }

  // Analisis kebiasaan waktu produktif (jika sering reservasi di jam tertentu)
  const [frequentTime]: any = await pool.query(
    `SELECT reservation_time, room_type, COUNT(*) as count 
         FROM reservations
         WHERE user_id = ? 
         GROUP BY reservation_time, room_type 
         ORDER BY count DESC 
         LIMIT 1`,
    [userId]
  );

  if (frequentTime.length > 0 && frequentTime[0].count > 2) {
    const { reservation_time, room_type } = frequentTime[0];
    // Fix second error by adding proper typing
    const [roomInfo] = await pool.query<RoomTable[]>(
      `SELECT * FROM room_tables WHERE room_type = ? LIMIT 1`,
      [room_type]
    );

    return {
      title: "Waktu Produktif Anda",
      message: `Anda sering produktif di ${room_type} sekitar jam ${reservation_time.substring(
        0,
        5
      )}. Pesan lagi untuk sesi berikutnya?`,
      type: "reservation",
      items: roomInfo,
    };
  }

  return null;
}
