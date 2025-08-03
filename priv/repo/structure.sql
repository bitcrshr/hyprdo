CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" INTEGER PRIMARY KEY, "inserted_at" TEXT);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "tasks" ("id" TEXT PRIMARY KEY, "title" TEXT NOT NULL, "description" TEXT NOT NULL, "status" TEXT DEFAULT 'TASK_STATUS_UNSPECIFIED' NOT NULL, "estimated_time" DURATION, "actual_time" DURATION, "created_at" TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL, "updated_at" TEXT NULL);
INSERT INTO schema_migrations VALUES(20250731220009,'2025-08-03T15:01:16');
