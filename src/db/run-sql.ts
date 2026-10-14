import { sql, type Kysely } from 'kysely';

export async function runSql(
  db: Kysely<any>,
  source: string,
): Promise<void> {
  const statements = source
    .split(';')
    .map((statement) => statement.trim())
    .filter((statement) => statement.length > 0);

  for (const statement of statements) {
    await sql.raw(statement).execute(db);
  }
}