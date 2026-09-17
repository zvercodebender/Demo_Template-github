--liquibase formatted sql

--changeset jbennett:ddl_create_table_organizations labels:release-1.0.0
--comment Release 1.0.0
SELECT * FROM ORGANIZATIONS;

