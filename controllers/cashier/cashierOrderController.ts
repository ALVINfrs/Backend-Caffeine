import { Request, Response } from 'express';
import db from '../../config/database';
import midtransClient from 'midtrans-client';

// Inisialisasi Midtrans Snap
const snap = new midtransClient.Snap({
    isProduction: process.env.MIDTRANS_IS_PRODUCTION === 'true',
    serverKey: process.env.MIDTRANS_SERVER_KEY,
    clientKey: process.env.MIDTRANS_CLIENT_KEY,
});

interface PosOrderItem {
    id: number;
    price: number;
    quantity: number;
    name: string;
}

export const getCashierOrders = async (req: Request, res: Response) => {
    const cashier_id = req.session.user?.id;
    const page = parseInt(req.query.page as string) || 1;
    const limit = parseInt(req.query.limit as string) || 10;
    const offset = (page - 1) * limit;

    if (!cashier_id) {
        return res.status(403).json({ message: 'User tidak dikenali.' });
    }

    try {
        const [orders] = await db.query(
            'SELECT * FROM orders WHERE cashier_id = ? ORDER BY order_date DESC LIMIT ? OFFSET ?',
            [cashier_id, limit, offset]
        );

        const [[{ total }]] : any = await db.query(
            'SELECT COUNT(*) as total FROM orders WHERE cashier_id = ?',
            [cashier_id]
        );

        res.json({
            data: orders,
            pagination: {
                page,
                limit,
                total,
                totalPages: Math.ceil(total / limit)
            }
        });
    } catch (error) {
        console.error('Error fetching cashier orders:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
};

export const createPosOrder = async (req: Request, res: Response) => {
    const { items, customer_name, payment_method, order_type } = req.body; // dine_in atau take_away
    const cashier_id = req.session.user?.id;

    if (!cashier_id) {
        return res.status(403).json({ message: 'Akses ditolak. Hanya kasir atau admin yang bisa membuat pesanan.' });
    }

    const connection = await db.getConnection();
    await connection.beginTransaction();

    try {
        const subtotal = items.reduce((sum: number, item: PosOrderItem) => sum + (item.price * item.quantity), 0);
        const total = subtotal; // Di POS, subtotal = total karena tidak ada ongkir

        const orderNumber = `POS-${Date.now()}`;

        // 1. Simpan data pesanan awal
        const [orderResult]: any = await connection.query(
            `INSERT INTO orders (user_id, order_number, customer_name, email, phone, address, subtotal, shipping_fee, total, payment_method, status, order_type, order_source, cashier_id)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pos', ?)`,
            [null, orderNumber, customer_name, 'pos@system.com', '0000', 'On-Site', subtotal, 0, total, payment_method, 'pending', order_type, cashier_id]
        );
        const orderId = orderResult.insertId;

        // 2. Simpan item-item pesanan
        const orderItems = items.map((item: PosOrderItem) => [orderId, item.id, item.name, item.price, item.quantity, item.price * item.quantity]);
        await connection.query('INSERT INTO order_items (order_id, product_id, product_name, price, quantity, subtotal) VALUES ?', [orderItems]);

        // 3. Proses pembayaran
        if (payment_method === 'cash') {
            // Jika bayar tunai, langsung selesaikan pesanan
            await connection.query(`UPDATE orders SET status = 'completed' WHERE id = ?`, [orderId]);
            await connection.commit();
            res.status(201).json({ success: true, message: 'Pesanan tunai berhasil dibuat.', orderId, orderNumber });
        } else {
            // Jika pembayaran non-tunai, buat transaksi Midtrans
            const itemDetails = items.map((item: PosOrderItem) => ({
                id: item.id.toString(),
                price: item.price,
                quantity: item.quantity,
                name: item.name,
            }));

            const midtransParameter = {
                transaction_details: { order_id: orderNumber, gross_amount: total },
                customer_details: { first_name: customer_name, email: 'pos@system.com' },
                item_details: itemDetails,
                enabled_payments: payment_method !== 'all' ? [payment_method] : undefined
            };

            const snapResponse = await snap.createTransaction(midtransParameter);

            // Update order dengan snap token dari Midtrans
            await connection.query('UPDATE orders SET snap_token = ?, snap_redirect_url = ? WHERE id = ?', [snapResponse.token, snapResponse.redirect_url, orderId]);
            
            await connection.commit();
            res.status(201).json({
                success: true,
                message: 'Transaksi Midtrans berhasil dibuat.',
                orderId,
                orderNumber,
                snapToken: snapResponse.token,
                redirectUrl: snapResponse.redirect_url,
            });
        }
    } catch (error) {
        await connection.rollback();
        console.error('POS Order creation error:', error);
        res.status(500).json({ message: 'Gagal membuat pesanan POS' });
    } finally {
        connection.release();
    }
};
