CREATE TABLE "addresses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "zip" varchar(255), "street" varchar(255), "state" varchar(255), "country" varchar(255), "owner_type" varchar(255), "owner_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "administrators" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "appointments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "start_time" datetime, "end_time" datetime, "phy_id" integer, "pat_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "emails" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email_type" varchar(255), "email" varchar(255), "owner_type" varchar(255), "owner_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "health_prices" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "insure_code" varchar(255), "cost" float, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "logins" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255), "password_hash" varchar(255), "password_salt" varchar(255), "owner_type" varchar(255), "owner_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "patients" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "primary_phy_id" integer, "date_of_birth" date, "pharmacy_id" integer, "insurance_id" integer, "created_at" datetime, "updated_at" datetime, "firstname" varchar(255), "middlename" varchar(255), "lastname" varchar(255));
CREATE TABLE "phones" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "phone_type" varchar(255), "phone" varchar(255), "owner_type" varchar(255), "owner_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "physicians" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "specialty" varchar(255), "office_num" integer, "created_at" datetime, "updated_at" datetime, "firstname" varchar(255), "middlename" varchar(255), "lastname" varchar(255));
CREATE TABLE "schedules" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "start_time" datetime, "end_time" datetime, "phy_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120212034138');

INSERT INTO schema_migrations (version) VALUES ('20120212034602');

INSERT INTO schema_migrations (version) VALUES ('20120212034626');

INSERT INTO schema_migrations (version) VALUES ('20120212035202');

INSERT INTO schema_migrations (version) VALUES ('20120212035819');

INSERT INTO schema_migrations (version) VALUES ('20120212040242');

INSERT INTO schema_migrations (version) VALUES ('20120212040327');

INSERT INTO schema_migrations (version) VALUES ('20120212040406');

INSERT INTO schema_migrations (version) VALUES ('20120218190802');

INSERT INTO schema_migrations (version) VALUES ('20120218191301');

INSERT INTO schema_migrations (version) VALUES ('20120218191331');

INSERT INTO schema_migrations (version) VALUES ('20120219002131');