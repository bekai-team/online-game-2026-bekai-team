import "reflect-metadata"
import { DataSource } from "typeorm"

export const AppDataSource = new DataSource({
    type: "postgres",
    host: "localhost",
    port: 5433, // Твій порт із docker-compose
    username: "your_username", 
    password: "your_password", 
    database: "your_db",       
    synchronize: false,
    logging: true,
    entities: [],
    migrations: ["src/migrations/*.ts"],
})