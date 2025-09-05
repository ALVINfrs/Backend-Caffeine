import { Router } from "express";
import multer from "multer";
import path from "path";
import { isAdmin } from "../../middleware/admin/auth";
import {
  getAllEvents,
  createEvent,
  updateEvent,
  deleteEvent,
} from "../../controllers/admin/eventAdminController";

const router = Router();

// Konfigurasi Multer untuk penyimpanan gambar event
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public/img/events");
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(
      null,
      file.fieldname + "-" + uniqueSuffix + path.extname(file.originalname)
    );
  },
});

const upload = multer({ storage: storage });

// Melindungi semua rute di bawah ini dengan middleware isAdmin
router.use(isAdmin);

router.get("/", getAllEvents);
router.post("/", upload.single("image"), createEvent);
router.put("/:id", upload.single("image"), updateEvent);
router.delete("/:id", deleteEvent);

export default router;
