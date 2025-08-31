import "dotenv/config";
import express from "express";
import cors from "cors";
import path from "path";
import bodyParser from "body-parser";
import { testConnection } from "./config/database";
import sessionConfig from "./config/session";
import swaggerUi from "swagger-ui-express";
import swaggerSpec from "./config/swagger";

import authRoutes from "./routes/authRoutes";
import productRoutes from "./routes/productRoutes";
import orderRoutes from "./routes/orderRoutes";
import voucherRoutes from "./routes/voucherRoutes";
import reservationRoutes from "./routes/reservationRoutes";
import adminDashboardRoutes from "./routes/admin/dashboardRoutes";
import adminProductRoutes from "./routes/admin/productAdminRoutes";
import adminReservationRoutes from "./routes/admin/reservationAdminRoutes";
import adminUserRoutes from "./routes/admin/userAdminRoutes";
import adminVoucherRoutes from "./routes/admin/voucherAdminRoutes";
import cashierOrderRoutes from "./routes/cashier/orderRoutes";
import intelligentRecommendationRoutes from "./routes/intelligentRecommendationRoutes";

const app = express();
app.set("trust proxy", 1);
const PORT: number | string = process.env.PORT || 3000;

app.use(
  cors({
    origin: [
      "http://localhost:3001", // untuk development
      "https://caffeine-fullstack-fix.vercel.app", // atau domain frontend yang sudah deploy
      "https://caffeine-fullstack-fix-production.up.railway.app", // jika frontend juga di railway
    ],
    credentials: true,
  })
);

app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, "public")));
app.use(sessionConfig);

testConnection();

app.use("/api/auth", authRoutes);
app.use("/api/products", productRoutes);
app.use("/api/orders", orderRoutes);
app.use("/api/vouchers", voucherRoutes);
app.use("/api/reservations", reservationRoutes);
app.use("/api/admin/dashboard", adminDashboardRoutes);
app.use("/api/admin/products", adminProductRoutes);
app.use("/api/admin/reservations", adminReservationRoutes);
app.use("/api/admin/users", adminUserRoutes);
app.use("/api/admin/vouchers", adminVoucherRoutes);
app.use("/api/cashier/orders", cashierOrderRoutes);
app.use("/api/recomendations", intelligentRecommendationRoutes);
// Swagger UI
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

export default app;
