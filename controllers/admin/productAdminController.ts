import { Request, Response } from 'express';
import db from '../../config/database';

// Mendapatkan semua produk dengan paginasi
export const getAllProducts = async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string) || 1;
  const limit = parseInt(req.query.limit as string) || 10;
  const offset = (page - 1) * limit;

  try {
    const [products] = await db.query('SELECT * FROM products LIMIT ? OFFSET ?', [limit, offset]);
    const [[{ total }]] : any = await db.query('SELECT COUNT(*) as total FROM products');
    
    res.json({
      data: products,
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

// Mendapatkan produk berdasarkan ID
export const getProductById = async (req: Request, res: Response) => {
  try {
    const [product] = await db.query('SELECT * FROM products WHERE id = ?', [req.params.id]);
    // @ts-ignore
    if (product.length === 0) {
      return res.status(404).json({ message: 'Produk tidak ditemukan' });
    }
    res.json(product[0]);
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

// Membuat produk baru
export const createProduct = async (req: Request, res: Response) => {
  const { name, description, price, category, is_featured } = req.body;
  const image = req.file ? `/img/products/${req.file.filename}` : '/img/products/default.jpg';

  try {
    const [result] : any = await db.query(
      'INSERT INTO products (name, description, price, image, category, is_featured) VALUES (?, ?, ?, ?, ?, ?)',
      [name, description, price, image, category, is_featured || 0]
    );
    res.status(201).json({ id: result.insertId, name, description, price, image, category, is_featured });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

// Memperbarui produk
export const updateProduct = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { name, description, price, category, is_featured } = req.body;
  
  try {
    // Cek apakah produk ada
    const [product]: any = await db.query('SELECT * FROM products WHERE id = ?', [id]);
    if (product.length === 0) {
      return res.status(404).json({ message: 'Produk tidak ditemukan' });
    }

    // Gunakan gambar baru jika diunggah, jika tidak gunakan gambar yang lama
    const image = req.file ? `/img/products/${req.file.filename}` : product[0].image;

    await db.query(
      'UPDATE products SET name = ?, description = ?, price = ?, image = ?, category = ?, is_featured = ? WHERE id = ?',
      [name, description, price, image, category, is_featured, id]
    );
    res.json({ id, name, description, price, image, category, is_featured });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

// Menghapus produk
export const deleteProduct = async (req: Request, res: Response) => {
  try {
    const [result]: any = await db.query('DELETE FROM products WHERE id = ?', [req.params.id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Produk tidak ditemukan' });
    }
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};
