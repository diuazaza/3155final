import 'dotenv/config';
import { promises as fs } from 'node:fs';
import path from 'node:path';
import { pathToFileURL } from 'node:url';
import {
  FileMigrationProvider,
  Migrator,
} from 'kysely/migration';
import { db, closeDatabase } from './connection.js';

async function main(): Promise<void> {
  const migrationFolder = path.resolve(
    process.cwd(),
    'src',
    'db',
    'migrations',
  );

  const migrator = new Migrator({
    db,
    provider: new FileMigrationProvider({
      fs,
      path,
      migrationFolder,

      // Convert Windows paths to valid file URLs for ESM imports.
      import: (filePath) =>
        import(pathToFileURL(filePath).href),
    }),
  });

  const { error, results } = await migrator.migrateToLatest();

  for (const result of results ?? []) {
    console.log(`${result.status}: ${result.migrationName}`);
  }

  if (error) {
    throw error;
  }

  if (!results?.length) {
    console.log('No pending migrations.');
  }
}

main()
  .catch((error) => {
    console.error('Migration failed:', error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await closeDatabase();
  });