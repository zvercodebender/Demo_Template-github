--liquibase formatted sql

--changeset jbennett:ddl_create_table_organizations labels:release-1.0.0
--comment Release 1.0.0
CREATE TABLE ORGANIZATIONS (
    ID             INT           NOT NULL,
    NAME           VARCHAR(200)  NULL,
    INDUSTRY       VARCHAR(400)  NULL,
    EMPLOYEE_COUNT INT           NULL,
    CONSTRAINT PK_ORGANIZATIONS PRIMARY KEY (ID)
);
--rollback DROP TABLE ORGANIZATIONS;

--changeset jbennett:dml_insert_organizations labels:release-1.0.0
--comment Release 1.0.0
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (1, 'Acme Corporation', 'Explosives', 1);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (2, 'Initech', 'Y2K', 50);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (3, 'Umbrella Corporation', 'Zombies', 10000);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (4, 'Soylent Corp', 'People', 100);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (5, 'Globex Corp', 'Widgets', 5000);
--rollback DELETE FROM ORGANIZATIONS WHERE ID BETWEEN 1 AND 5;

--changeset dzentgraf:ddl_create_table_addresses labels:release-1.0.1
--comment Release 1.0.1
CREATE TABLE ADDRESSES (
    ID             INT           NOT NULL,
    ADDRESS_LINE_1 VARCHAR(500)  NULL,
    CITY           VARCHAR(200)  NULL,
    STATE          VARCHAR(3)    NULL,
    ZIP_CODE       VARCHAR(9)    NULL,
    ORG_ID         INT           NULL,
    CONSTRAINT PK_ADDRESSES PRIMARY KEY (ID)
);
--rollback DROP TABLE ADDRESSES;

--changeset dzentgraf:ddl_create_fk_addresses labels:release-1.0.1
--comment Release 1.0.1
ALTER TABLE ADDRESSES
    ADD CONSTRAINT ORG_FK1 FOREIGN KEY (ORG_ID) REFERENCES ORGANIZATIONS (ID);
--rollback ALTER TABLE ADDRESSES DROP CONSTRAINT ORG_FK1;

--changeset dzentgraf:ddl_create_table_employees labels:release-1.0.1
--comment Release 1.0.1
CREATE TABLE EMPLOYEES (
    ID             INT           NOT NULL,
    FIRST_NAME     VARCHAR(200)  NULL,
    LAST_NAME      VARCHAR(200)  NULL,
    DATE_OF_BIRTH  DATE          NULL,
    EMAIL_ADDRESS  VARCHAR(200)  NULL,
    ORG_ID         INT           NULL,
    CONSTRAINT PK_EMPLOYEES PRIMARY KEY (ID)
);
--rollback DROP TABLE EMPLOYEES;

--changeset dzentgraf:dml_insert_employees labels:release-1.0.1
--comment Release 1.0.1
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (1, 'Taylor',  'Morgan', '1988-04-15', 'redacted@example.com', 1);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (2, 'Jordan',  'Lee',    '1992-09-03', 'redacted@example.com', 2);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (3, 'Casey',   'Nguyen', '1985-12-22', 'redacted@example.com', 3);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (4, 'Riley',   'Patel',  '1990-06-11', 'redacted@example.com', 4);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (5, 'Avery',   'Chen',   '1995-02-27', 'redacted@example.com', 5);
--rollback DELETE FROM EMPLOYEES WHERE ID BETWEEN 1 AND 5;

--changeset molivas:ddl_create_fk_employees labels:release-1.0.2
--comment Release 1.0.2
ALTER TABLE EMPLOYEES
    ADD CONSTRAINT ORG_FK2 FOREIGN KEY (ORG_ID) REFERENCES ORGANIZATIONS (ID);
--rollback ALTER TABLE EMPLOYEES DROP CONSTRAINT ORG_FK2;

--changeset molivas:sp_create_getemployeesbyorg labels:release-1.0.2 splitStatements:false runOnChange:true
--comment Release 1.0.2
CREATE OR ALTER PROCEDURE get_employees_by_org
    @p_org_id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        e.ID,
        e.FIRST_NAME,
        e.LAST_NAME,
        e.DATE_OF_BIRTH
    FROM EMPLOYEES e
    WHERE e.ORG_ID = @p_org_id;
END;
--rollback DROP PROCEDURE IF EXISTS get_employees_by_org;

--changeset jbennett:dml_email_fix labels:jira-1388,release-1.0.3
--comment Release 1.0.3
UPDATE EMPLOYEES SET EMAIL_ADDRESS = 'taylor.morgan2@example.com' WHERE ID = 1;
--rollback UPDATE EMPLOYEES SET EMAIL_ADDRESS = 'redacted@example.com' WHERE ID = 1;

--changeset mikeo:dcl_grant_employee_guest labels:jira-1412,release-1.0.3
--comment Release 1.0.3
GRANT SELECT ON EMPLOYEES TO guest;
--rollback REVOKE SELECT ON EMPLOYEES FROM guest;