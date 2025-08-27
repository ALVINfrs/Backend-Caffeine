import { Request, Response, NextFunction } from "express";

// Update SessionData interface with correct user type
declare module "express-session" {
  interface SessionData {
    user?: {
      id: number;
      name: string;
      email: string;
      phone: string; // Add missing phone property
      role: string;
    };
  }
}

export const isAdmin = (req: Request, res: Response, next: NextFunction) => {
  if (req.session.user && req.session.user.role === "admin") {
    return next();
  }
  res.status(403).json({ message: "Akses ditolak: Anda bukan admin." });
};

export const isCashier = (req: Request, res: Response, next: NextFunction) => {
  if (
    req.session.user &&
    (req.session.user.role === "cashier" || req.session.user.role === "admin")
  ) {
    return next();
  }
  res
    .status(403)
    .json({ message: "Akses ditolak: Anda bukan kasir atau admin." });
};
