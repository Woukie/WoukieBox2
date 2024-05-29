BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "userpersistent" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "userpersistent" (
    "id" serial PRIMARY KEY,
    "userInfoId" integer NOT NULL,
    "color" text NOT NULL,
    "bio" text NOT NULL,
    "image" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_info_id_unique_idx" ON "userpersistent" USING btree ("userInfoId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "userpersistent"
    ADD CONSTRAINT "userpersistent_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR woukiebox2
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('woukiebox2', '20240528214545289', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240528214545289', "timestamp" = now();

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
