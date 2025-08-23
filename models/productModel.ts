import { pool } from "../config/database";
import { RowDataPacket } from "mysql2";

interface Product extends RowDataPacket {
    id: number;
    name: string;
    description: string;
    price: number;
    category: string;
    image: string;
    stock: number;
}

async function getAllProducts(): Promise<Product[]> {
    const [rows] = await pool.query<Product[]>("SELECT * FROM products");
    return rows;
}

async function getProductById(id: number): Promise<Product | null> {
    const [rows] = await pool.query<Product[]>("SELECT * FROM products WHERE id = ?", [id]);
    return rows.length > 0 ? rows[0] : null;
}

export {
    getAllProducts,
    getProductById,
};
