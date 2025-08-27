import { Request, Response } from "express";
import * as userModel from "../models/userModel";

// Augment express-session to include user with role
declare module "express-session" {
  interface SessionData {
    userId: number;
    user?: {
      id: number;
      name: string;
      email: string;
      phone: string;
      role: string; // Role is important for auth middleware
    };
  }
}

async function register(req: Request, res: Response): Promise<Response> {
  const { name, email, password, phone } = req.body;

  try {
    const existingUser = await userModel.findByEmail(email);

    if (existingUser) {
      return res.status(400).json({ error: "Email sudah terdaftar" });
    }

    const userId = await userModel.createUser(name, email, password, phone);

    return res.status(201).json({
      success: true,
      message: "Registrasi berhasil",
      userId: userId,
    });
  } catch (error) {
    console.error("Registration error:", error);
    return res.status(500).json({ error: "Gagal mendaftar" });
  }
}

async function login(req: Request, res: Response): Promise<Response> {
  const { email, password } = req.body;

  try {
    const user = await userModel.findByEmail(email);

    if (!user) {
      return res.status(401).json({ error: "Email atau password salah" });
    }

    const isPasswordValid = await userModel.validatePassword(
      password,
      user.password
    );

    if (!isPasswordValid) {
      return res.status(401).json({ error: "Email atau password salah" });
    }

    req.session.userId = user.id;
    req.session.user = {
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      role: user.role, // Add role to session
    };

    return res.json({
      success: true,
      message: "Login berhasil",
      user: req.session.user,
    });
  } catch (error) {
    console.error("Login error:", error);
    return res.status(500).json({ error: "Gagal login" });
  }
}

async function staffLogin(req: Request, res: Response): Promise<Response> {
  const { email, password } = req.body;

  try {
    const user = await userModel.findByEmail(email);

    if (!user) {
      return res.status(401).json({ error: "Email atau password salah" });
    }

    const isPasswordValid = await userModel.validatePassword(
      password,
      user.password
    );

    if (!isPasswordValid) {
      return res.status(401).json({ error: "Email atau password salah" });
    }

    // *** INI PERBEDAAN UTAMANYA ***
    // Cek apakah role-nya admin atau kasir
    if (user.role !== "admin" && user.role !== "cashier") {
      return res
        .status(403)
        .json({ error: "Akses ditolak. Akun Anda bukan akun staf." });
    }

    req.session.userId = user.id;
    req.session.user = {
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      role: user.role,
    };

    return res.json({
      success: true,
      message: "Login staf berhasil",
      user: req.session.user,
    });
  } catch (error) {
    console.error("Staff login error:", error);
    return res.status(500).json({ error: "Gagal login" });
  }
}

function logout(req: Request, res: Response): void {
  req.session.destroy((err) => {
    if (err) {
      res.status(500).json({ error: "Gagal logout" });
      return;
    }
    res.clearCookie("connect.sid"); // Hapus cookie session
    res.json({ success: true, message: "Logout berhasil" });
  });
}

function getAuthStatus(req: Request, res: Response): void {
  if (req.session.user) {
    res.json({
      isAuthenticated: true,
      user: req.session.user,
    });
  } else {
    res.json({ isAuthenticated: false });
  }
}

export {
  register,
  login,
  staffLogin, // Export fungsi baru
  logout,
  getAuthStatus,
};
