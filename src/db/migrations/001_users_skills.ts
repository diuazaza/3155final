import type { Kysely } from 'kysely';
import { runSql } from '../run-sql.js';

const statements = `
CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    bio TEXT,
    avatar_url VARCHAR(512),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE skills (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE user_skills (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    skill_id INT NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
    proficiency_level VARCHAR(20) CHECK (proficiency_level IN ('Beginner', 'Intermediate', 'Advanced', 'Expert')),
    is_open_to_teach BOOLEAN DEFAULT FALSE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, skill_id)
);

CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_skills_name ON skills(name);
CREATE INDEX idx_user_skills_teach ON user_skills(skill_id) WHERE is_open_to_teach = TRUE;
`;

export async function up(db: Kysely<any>): Promise<void> {
  await runSql(db, statements);
}

export async function down(db: Kysely<any>): Promise<void> {
  await runSql(
    db,
    `
    DROP TABLE user_skills;
    DROP TABLE skills;
    DROP TABLE users;
    `,
  );
}