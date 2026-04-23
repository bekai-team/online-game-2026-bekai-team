import { MigrationInterface, QueryRunner } from "typeorm"

export class SeedData1713900000001 implements MigrationInterface {
    public async up(queryRunner: QueryRunner): Promise<void> {
        // Додаємо стартові локації
        await queryRunner.query(`
            INSERT INTO locations (name, region, environment_state) VALUES 
            ('Neon Hub', 'Sector A', 'clear'),
            ('Acid Marsh', 'Sector B', 'acid_rain');
        `);

        // Додаємо тестового користувача (потрібен для персонажа)
        await queryRunner.query(`
            INSERT INTO users (email, password_hash) VALUES 
            ('dev_tester@maditron.com', 'scrypt_hash_example');
        `);

        // Додаємо ворогів (Enemies) — як просив PM (3-10 штук)
        await queryRunner.query(`
            INSERT INTO enemies (name, level, hp_max, hp_current, damage_base, behavior_type) VALUES 
            ('Glitch Spider', 1, 40, 40, 5, 'aggressive'),
            ('Heavy Sentry', 5, 200, 200, 25, 'defensive'),
            ('Shadow Sniper', 3, 80, 80, 40, 'sniper');
        `);

        // Додаємо NPC
        await queryRunner.query(`
            INSERT INTO npcs (name, role_type, base_prompt) VALUES 
            ('Morpheus', 'informant', 'I know everything about the Matrix.');
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        // Видаляємо дані у зворотному порядку
        await queryRunner.query(`DELETE FROM npcs;`);
        await queryRunner.query(`DELETE FROM enemies;`);
        await queryRunner.query(`DELETE FROM users;`);
        await queryRunner.query(`DELETE FROM locations;`);
    }
}