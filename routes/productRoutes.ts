import express from "express";
import * as productController from "../controllers/productController";

const router = express.Router();

router.get("/", productController.getAllProducts);

export default router;
