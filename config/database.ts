import "dotenv/config";
import mysql, { Pool } from "mysql2/promise";

const pool: Pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: Number(process.env.DB_PORT),
  waitForConnections: true,
  connectionLimit: 20,
  queueLimit: 0,
});

async function testConnection(): Promise<void> {
  try {
    const connection = await pool.getConnection();
    console.log("Database connection successful");
    connection.release();
  } catch (error) {
    console.error("Database connection failed:", error);
  }
}

export { pool, testConnection };
