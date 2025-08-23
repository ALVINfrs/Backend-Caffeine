import { Request, Response, NextFunction } from "express";

function isAuthenticated(req: Request, res: Response, next: NextFunction): void {
  if (req.session.userId) {
    next();
  } else {
    res.status(401).json({ error: "Unauthorized" });
  }
}

export { isAuthenticated };
