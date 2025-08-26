import { Router } from 'express';
import { isCashier } from '../../middleware/admin/auth';
import { createPosOrder, getCashierOrders } from '../../controllers/cashier/cashierOrderController';

const router = Router();

// Rute ini hanya bisa diakses oleh kasir atau admin
router.use(isCashier);

router.get('/', getCashierOrders);
router.post('/', createPosOrder);

export default router;
