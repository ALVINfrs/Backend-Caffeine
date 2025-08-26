import { Router } from 'express';
import { isAdmin } from '../../middleware/admin/auth';
import {
    getAllReservations,
    getReservationById,
    updateReservation,
    deleteReservation
} from '../../controllers/admin/reservationAdminController';

const router = Router();

// Semua rute di sini akan dilindungi oleh middleware isAdmin atau middleware role lainnya jika diperlukan
router.use(isAdmin);

router.get('/', getAllReservations);
router.get('/:id', getReservationById);
router.put('/:id', updateReservation);
router.delete('/:id', deleteReservation);

export default router;
