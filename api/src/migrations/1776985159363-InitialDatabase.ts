import { MigrationInterface, QueryRunner } from "typeorm";

export class InitialDatabase1713900000000 implements MigrationInterface {
    public async up(queryRunner: QueryRunner): Promise<void> {
        // 1. Створюємо розширення та типи
        await queryRunner.query(`CREATE EXTENSION IF NOT EXISTS "pgcrypto";`);
        
        await queryRunner.query(`
            DO $$ BEGIN
                IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'player_status') THEN
                    CREATE TYPE player_status AS ENUM ('active', 'banned', 'offline');
                END IF;
                IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'environment_type') THEN
                    CREATE TYPE environment_type AS ENUM ('clear', 'acid_rain', 'neon_fog', 'emp_storm');
                END IF;
                IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'quest_status') THEN
                    CREATE TYPE quest_status AS ENUM ('active', 'completed', 'failed');
                END IF;
                IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'npc_role') THEN
                    CREATE TYPE npc_role AS ENUM ('merchant', 'hacker', 'corpo', 'informant');
                END IF;
                IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'item_category') THEN
                    CREATE TYPE item_category AS ENUM ('weapon', 'implant', 'cosmetic', 'quest_item');
                END IF;
                IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'behavior_type') THEN
                    CREATE TYPE behavior_type AS ENUM ('aggressive', 'defensive', 'sniper');
                END IF;
            END $$;
        `);

        // 2. Створюємо таблиці (по черзі, щоб уникнути помилок Foreign Key)
        await queryRunner.query(`
            CREATE TABLE IF NOT EXISTS users (
                user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                email VARCHAR(255) UNIQUE NOT NULL,
                password_hash TEXT NOT NULL,
                status player_status DEFAULT 'active',
                created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
            );

            CREATE TABLE IF NOT EXISTS locations (
                location_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                name VARCHAR(100) NOT NULL,
                description TEXT,
                region VARCHAR(100),
                environment_state environment_type DEFAULT 'clear',
                special_modifiers JSONB
            );

            CREATE TABLE IF NOT EXISTS characters (
                char_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                player_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
                nickname VARCHAR(50) UNIQUE NOT NULL,
                level INTEGER DEFAULT 1,
                exp BIGINT DEFAULT 0,
                hp_current INTEGER DEFAULT 100,
                coordinates JSONB DEFAULT '{"x": 0, "y": 0}',
                currency INTEGER DEFAULT 0,
                current_location_id UUID REFERENCES locations(location_id) ON DELETE SET NULL
            );

            CREATE TABLE IF NOT EXISTS npcs (
                npc_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                location_id UUID REFERENCES locations(location_id) ON DELETE CASCADE,
                name VARCHAR(100) NOT NULL,
                role_type npc_role DEFAULT 'informant',
                base_prompt TEXT NOT NULL,
                mood_score FLOAT DEFAULT 0.0
            );

            CREATE TABLE IF NOT EXISTS enemies (
                enemy_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                name VARCHAR(100) NOT NULL,
                level INTEGER DEFAULT 1,
                hp_max INTEGER NOT NULL,
                hp_current INTEGER NOT NULL,
                damage_base INTEGER NOT NULL,
                armor_class INTEGER DEFAULT 0,
                behavior_type behavior_type DEFAULT 'aggressive',
                location_id UUID REFERENCES locations(location_id) ON DELETE CASCADE
            );

            CREATE TABLE IF NOT EXISTS items (
                item_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                owner_id UUID REFERENCES characters(char_id) ON DELETE CASCADE,
                name VARCHAR(100) NOT NULL,
                item_type item_category DEFAULT 'cosmetic',
                metadata JSONB,
                weight FLOAT DEFAULT 0.0
            );

            CREATE TABLE IF NOT EXISTS quests (
                quest_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                issuer_id UUID REFERENCES npcs(npc_id) ON DELETE SET NULL,
                title VARCHAR(150) NOT NULL,
                description TEXT,
                reward_data JSONB,
                is_dynamic BOOLEAN DEFAULT FALSE
            );

            CREATE TABLE IF NOT EXISTS dialogues (
                dialogue_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                char_id UUID REFERENCES characters(char_id) ON DELETE CASCADE,
                npc_id UUID REFERENCES npcs(npc_id) ON DELETE CASCADE,
                history_json JSONB NOT NULL,
                summary TEXT,
                updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
            );

            CREATE TABLE IF NOT EXISTS character_quests (
                char_id UUID NOT NULL REFERENCES characters(char_id) ON DELETE CASCADE,
                quest_id UUID NOT NULL REFERENCES quests(quest_id) ON DELETE CASCADE,
                status quest_status DEFAULT 'active',
                started_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (char_id, quest_id)
            );
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        // Метод для повного відкату бази (Завдання 2, пункт 3)
        await queryRunner.query(`DROP TABLE IF EXISTS character_quests CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS dialogues CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS quests CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS items CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS enemies CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS npcs CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS characters CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS locations CASCADE;`);
        await queryRunner.query(`DROP TABLE IF EXISTS users CASCADE;`);
        
        // Видалення типів
        await queryRunner.query(`DROP TYPE IF EXISTS behavior_type;`);
        await queryRunner.query(`DROP TYPE IF EXISTS item_category;`);
        await queryRunner.query(`DROP TYPE IF EXISTS npc_role;`);
        await queryRunner.query(`DROP TYPE IF EXISTS quest_status;`);
        await queryRunner.query(`DROP TYPE IF EXISTS environment_type;`);
        await queryRunner.query(`DROP TYPE IF EXISTS player_status;`);
    }
}