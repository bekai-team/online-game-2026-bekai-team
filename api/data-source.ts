import { DataSource } from "typeorm";
import * as dotenv from "dotenv";

// Завантажуємо змінні з .env файлу
dotenv.config();

export const AppDataSource = new DataSource({
  type: "postgres",
  // Використовуємо змінні або значення за замовчуванням
  host: process.env.POSTGRES_HOST || "localhost",
  port: parseInt(process.env.POSTGRES_PORT || "5433"),
  username: process.env.POSTGRES_USER || "admin",
  password: process.env.POSTGRES_PASSWORD || "admin",
  database: process.env.POSTGRES_DB || "maditron_db",
  
  // КРИТИЧНО ВАЖЛИВІ НАЛАШТУВАННЯ:
  synchronize: true, // Автоматично створює таблиці при старті
  logging: true,     // Показує в консолі всі SQL-запити (зручно для дебагу)
  
  // Шлях до твоїх моделей (Entities)
  // Вказуємо шлях і для TS (src), і для збірки (dist)
  entities: [
    "src/**/*.entity{.ts,.js}",
    "dist/**/*.entity{.ts,.js}"
  ],
  
  // Шлях до міграцій
  migrations: [
    "src/migrations/*{.ts,.js}"
  ],
  subscribers: [],
});