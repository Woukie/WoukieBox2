BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "chat" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat" (
    "id" serial PRIMARY KEY,
    "users" json NOT NULL,
    "name" text NOT NULL,
    "owner" integer NOT NULL
);


--
-- MIGRATION VERSION FOR woukiebox2
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('woukiebox2', '20240610130049692', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240610130049692', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240115074239642', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074239642', "timestamp" = now();


COMMIT;