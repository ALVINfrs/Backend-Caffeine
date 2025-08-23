import { pool } from "../config/database";
import bcrypt from "bcryptjs";
import { RowDataPacket, ResultSetHeader } from "mysql2/promise";

interface User extends RowDataPacket {
    id: number;
    name: string;
    email: string;
    password: string;
    phone: string;
}

async function findByEmail(email: string): Promise<User | null> {
    const [users] = await pool.query<User[]>("SELECT * FROM users WHERE email = ?", [
        email,
    ]);
    return users.length > 0 ? users[0] : null;
}

async function createUser(name: string, email: string, password: string, phone: string): Promise<number> {
    const hashedPassword = bcrypt.hashSync(password, 10);

    const [result] = await pool.query<ResultSetHeader>(
        "INSERT INTO users (name, email, password, phone) VALUES (?, ?, ?, ?)",
        [name, email, hashedPassword, phone]
    );

    return result.insertId;
}

async function validatePassword(plainPassword: string, hashedPassword: string): Promise<boolean> {
    return bcrypt.compareSync(plainPassword, hashedPassword);
}

export {
    findByEmail,
    createUser,
    validatePassword,
};
