CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" INTEGER PRIMARY KEY, "inserted_at" TEXT);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "tasks" ("id" TEXT PRIMARY KEY, "title" TEXT, "description" TEXT);
INSERT INTO schema_migrations VALUES(20250731220009,'2025-07-31T23:29:55');
