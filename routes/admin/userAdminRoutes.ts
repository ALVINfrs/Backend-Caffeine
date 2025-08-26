import { Router } from 'express';
import { isAdmin } from '../../middleware/admin/auth';
import {
    getAllUsers,
    updateUserRole,
    deleteUser
} from '../../controllers/admin/userAdminController';

const router = Router();

router.use(isAdmin);

router.get('/', getAllUsers);
router.put('/:id/role', updateUserRole);
router.delete('/:id', deleteUser);

export default router;
