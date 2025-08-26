import { Router } from 'express';
import { isAdmin } from '../../middleware/admin/auth';
import {
    getAllVouchers,
    createVoucher,
    updateVoucher,
    deleteVoucher
} from '../../controllers/admin/voucherAdminController';

const router = Router();

router.use(isAdmin);

router.get('/', getAllVouchers);
router.post('/', createVoucher);
router.put('/:id', updateVoucher);
router.delete('/:id', deleteVoucher);

export default router;
