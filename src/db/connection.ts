import 'dotenv/config';
import { Kysely, PostgresDialect } from 'kysely';
import { Pool } from 'pg';

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error('DATABASE_URL is missing from your environment');
}

const pool = new Pool({
  connectionString,
});

export const db = new Kysely<any>({
  dialect: new PostgresDialect({ pool }),
});

export async function closeDatabase(): Promise<void> {
  await db.destroy();
}