"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_session_1 = __importDefault(require("express-session"));
const express_mysql_session_1 = __importDefault(require("express-mysql-session"));
// Konfigurasi koneksi ke MySQL dari .env
const dbOptions = {
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
};
const MySQLStore = (0, express_mysql_session_1.default)(express_session_1.default);
// Buat session store dari MySQL
const sessionStore = new MySQLStore(dbOptions);
// Middleware session
const sessionConfig = (0, express_session_1.default)({
    store: sessionStore,
    secret: process.env.SESSION_SECRET || 'some-secret',
    resave: false,
    saveUninitialized: false,
    cookie: {
        maxAge: 24 * 60 * 60 * 1000, // 1 hari
        secure: false, // ✅ FALSE untuk development (HTTP)
        httpOnly: true,
        sameSite: "lax", // ✅ "lax" untuk development, "none" untuk production
    },
});
exports.default = sessionConfig;
