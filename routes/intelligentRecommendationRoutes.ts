import express from "express";
import { getCombinedRecommendations } from "../controllers/intelligentRecommendationController";
import { isAuthenticated } from "../middleware/auth";

const router = express.Router();

/**
 * @swagger
 * tags:
 * name: Recommendations
 * description: API untuk rekomendasi cerdas dan terpersonalisasi
 */

/**
 * @swagger
 * /api/recommendations/combined:
 * get:
 * summary: Mendapatkan gabungan rekomendasi produk dan reservasi
 * tags: [Recommendations]
 * security:
 * - cookieAuth: []
 * description: |
 * Mengembalikan berbagai jenis rekomendasi yang telah dipersonalisasi untuk pengguna yang sedang login.
 * Ini termasuk rekomendasi produk berdasarkan pengguna lain, produk kontekstual untuk reservasi mendatang,
 * dan saran reservasi berdasarkan kebiasaan pengguna.
 * responses:
 * 200:
 * description: Berhasil mendapatkan gabungan rekomendasi.
 * content:
 * application/json:
 * schema:
 * type: object
 * properties:
 * success:
 * type: boolean
 * recommendations:
 * type: array
 * items:
 * type: object
 * 401:
 * description: Unauthorized, pengguna belum login.
 */
router.get("/combined", isAuthenticated, getCombinedRecommendations);

export default router;
