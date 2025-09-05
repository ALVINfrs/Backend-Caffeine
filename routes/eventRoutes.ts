import express from "express";
import * as eventController from "../controllers/eventController";

const router = express.Router();

/**
 * @swagger
 * tags:
 * name: Events
 * description: API untuk mengelola dan menampilkan event komunitas
 */

/**
 * @swagger
 * /api/events:
 * get:
 * summary: Mengambil semua event aktif yang akan datang
 * tags: [Events]
 * responses:
 * 200:
 * description: Daftar event berhasil diambil.
 */
router.get("/", eventController.getAllActiveEvents);

/**
 * @swagger
 * /api/events/{id}:
 * get:
 * summary: Mengambil detail satu event berdasarkan ID
 * tags: [Events]
 * parameters:
 * - in: path
 * name: id
 * required: true
 * schema:
 * type: integer
 * responses:
 * 200:
 * description: Detail event berhasil diambil.
 * 404:
 * description: Event tidak ditemukan.
 */
router.get("/:id", eventController.getEventDetails);

export default router;
