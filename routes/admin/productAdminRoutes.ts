import { Router } from 'express';
import multer from 'multer';
import path from 'path';
import { isAdmin } from '../../middleware/admin/auth';
import {
    getAllProducts,
    getProductById,
    createProduct,
    updateProduct,
    deleteProduct
} from '../../controllers/admin/productAdminController';

const router = Router();

// Konfigurasi Multer untuk penyimpanan gambar
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        // Pastikan path ini sesuai dengan struktur folder publik Anda
        cb(null, 'public/img/products'); 
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

// Semua rute di sini akan dilindungi oleh middleware isAdmin
router.use(isAdmin);

router.get('/', getAllProducts);
router.get('/:id', getProductById);
router.post('/', upload.single('image'), createProduct);
router.put('/:id', upload.single('image'), updateProduct);
router.delete('/:id', deleteProduct);

export default router;
