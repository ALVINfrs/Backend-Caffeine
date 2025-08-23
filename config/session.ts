import session from "express-session";
import MySQLStoreFactory from "express-mysql-session";

// Konfigurasi koneksi ke MySQL dari .env
const dbOptions = {
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
};

const MySQLStore = MySQLStoreFactory(session as any);

// Buat session store dari MySQL
const sessionStore = new MySQLStore(dbOptions);

// Middleware session
const sessionConfig = session({
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

export default sessionConfig;

