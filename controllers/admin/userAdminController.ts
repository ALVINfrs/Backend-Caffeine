import { Request, Response } from 'express';
import db from '../../config/database';

// Mendapatkan semua pengguna dengan paginasi
export const getAllUsers = async (req: Request, res: Response) => {
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 10;
    const offset = (page - 1) * limit;

    try {
        const [users] = await db.query('SELECT id, name, email, phone, role, created_at FROM users LIMIT ? OFFSET ?', [limit, offset]);
        const [[{ total }]] : any = await db.query('SELECT COUNT(*) as total FROM users');
        
        res.json({
            data: users,
            pagination: {
                page,
                limit,
                total,
                totalPages: Math.ceil(total / limit)
            }
        });
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error' });
    }
};

// Memperbarui role pengguna
export const updateUserRole = async (req: Request, res: Response) => {
    const { id } = req.params;
    const { role } = req.body;

    if (!['user', 'admin', 'cashier'].includes(role)) {
        return res.status(400).json({ message: 'Role tidak valid.' });
    }

    try {
        const [result]: any = await db.query('UPDATE users SET role = ? WHERE id = ?', [role, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Pengguna tidak ditemukan' });
        }
        res.json({ message: `Role pengguna berhasil diubah menjadi ${role}` });
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error' });
    }
};

// Menghapus pengguna
export const deleteUser = async (req: Request, res: Response) => {
    const { id } = req.params;
    // Tambahkan pengecekan agar admin tidak bisa menghapus dirinya sendiri
    // @ts-ignore
    if (req.session.user && req.session.user.id === parseInt(id)) {
        return res.status(400).json({ message: 'Anda tidak dapat menghapus akun Anda sendiri.' });
    }

    try {
        const [result]: any = await db.query('DELETE FROM users WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Pengguna tidak ditemukan' });
        }
        res.status(204).send();
    } catch (error) {
        // Tangani error jika ada foreign key constraint
        // @ts-ignore
        if (error.code === 'ER_ROW_IS_REFERENCED_2') {
            return res.status(400).json({ message: 'Tidak dapat menghapus pengguna ini karena masih memiliki data terkait (pesanan/reservasi).' });
        }
        res.status(500).json({ message: 'Internal Server Error' });
    }
};
