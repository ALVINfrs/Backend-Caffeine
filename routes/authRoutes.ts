import express from "express";
import * as authController from "../controllers/authController";

const router = express.Router();

/**
 * @swagger
 * tags:
 *   name: Authentication
 *   description: Rute untuk otentikasi pengguna (registrasi, login, logout)
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     User:
 *       type: object
 *       required:
 *         - name
 *         - email
 *         - password
 *         - phone
 *       properties:
 *         id:
 *           type: integer
 *           description: ID unik pengguna.
 *         name:
 *           type: string
 *           description: Nama lengkap pengguna.
 *         email:
 *           type: string
 *           format: email
 *           description: Alamat email pengguna.
 *         password:
 *           type: string
 *           format: password
 *           description: Kata sandi pengguna.
 *         phone:
 *           type: string
 *           description: Nomor telepon pengguna.
 *         role:
 *           type: string
 *           description: Peran pengguna (user, admin, cashier).
 *           enum: [user, admin, cashier]
 *           default: user
 */

/**
 * @swagger
 * /api/auth/register:
 *   post:
 *     summary: Registrasi pengguna baru
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - email
 *               - password
 *               - phone
 *             properties:
 *               name:
 *                 type: string
 *               email:
 *                 type: string
 *                 format: email
 *               password:
 *                 type: string
 *                 format: password
 *               phone:
 *                 type: string
 *     responses:
 *       201:
 *         description: Pengguna berhasil terdaftar.
 *       400:
 *         description: Email sudah terdaftar atau input tidak valid.
 */
router.post("/register", authController.register);

/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: Login untuk semua pengguna (pelanggan)
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *               password:
 *                 type: string
 *                 format: password
 *     responses:
 *       200:
 *         description: Login berhasil.
 *       401:
 *         description: Email atau password salah.
 */
router.post("/login", authController.login);

/**
 * @swagger
 * /api/auth/staff-login:
 *   post:
 *     summary: Login khusus untuk Admin dan Kasir
 *     tags: [Authentication]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *               password:
 *                 type: string
 *                 format: password
 *     responses:
 *       200:
 *         description: Login staf berhasil.
 *       401:
 *         description: Email atau password salah.
 *       403:
 *         description: Akses ditolak karena bukan role admin/kasir.
 */
router.post("/staff-login", authController.staffLogin);


/**
 * @swagger
 * /api/auth/logout:
 *   post:
 *     summary: Logout pengguna
 *     tags: [Authentication]
 *     security:
 *       - cookieAuth: []
 *     responses:
 *       200:
 *         description: Logout berhasil.
 *       500:
 *         description: Gagal untuk logout.
 */
router.post("/logout", authController.logout);

/**
 * @swagger
 * /api/auth/status:
 *   get:
 *     summary: Cek status otentikasi pengguna saat ini
 *     tags: [Authentication]
 *     security:
 *       - cookieAuth: []
 *     responses:
 *       200:
 *         description: Mengembalikan status login dan data pengguna jika terautentikasi.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 isLoggedIn:
 *                   type: boolean
 *                 user:
 *                   $ref: '#/components/schemas/User'
 *       401:
 *         description: Tidak terautentikasi.
 */
router.get("/status", authController.getAuthStatus);

export default router;
