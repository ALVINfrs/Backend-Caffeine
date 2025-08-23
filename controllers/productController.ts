import { Request, Response } from "express";
import * as productModel from "../models/productModel";

async function getAllProducts(req: Request, res: Response): Promise<Response> {
  try {
    const products = await productModel.getAllProducts();
    return res.json(products);
  } catch (error: any) {
    console.error("Error fetching products:", error);
    return res.status(500).json({ error: "Failed to fetch products" });
  }
}

export {
  getAllProducts,
};
