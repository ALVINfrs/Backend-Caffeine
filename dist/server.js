"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const path_1 = __importDefault(require("path"));
const body_parser_1 = __importDefault(require("body-parser"));
const database_1 = require("./config/database");
const session_1 = __importDefault(require("./config/session"));
const authRoutes_1 = __importDefault(require("./routes/authRoutes"));
const productRoutes_1 = __importDefault(require("./routes/productRoutes"));
const orderRoutes_1 = __importDefault(require("./routes/orderRoutes"));
const voucherRoutes_1 = __importDefault(require("./routes/voucherRoutes"));
const reservationRoutes_1 = __importDefault(require("./routes/reservationRoutes"));
const app = (0, express_1.default)();
app.set("trust proxy", 1);
const PORT = process.env.PORT || 3000;
app.use((0, cors_1.default)({
    origin: [
        "http://localhost:3001", // untuk development
        "https://caffeine-fullstack-fix.vercel.app", // atau domain frontend yang sudah deploy
        "https://caffeine-fullstack-fix-production.up.railway.app", // jika frontend juga di railway
    ],
    credentials: true,
}));
app.use(body_parser_1.default.json());
app.use(express_1.default.static(path_1.default.join(__dirname, "public")));
app.use(session_1.default);
(0, database_1.testConnection)();
app.use("/api/auth", authRoutes_1.default);
app.use("/api/products", productRoutes_1.default);
app.use("/api/orders", orderRoutes_1.default);
app.use("/api/vouchers", voucherRoutes_1.default);
app.use("/api/reservations", reservationRoutes_1.default);
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
exports.default = app;
