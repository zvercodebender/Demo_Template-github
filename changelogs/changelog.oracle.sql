--liquibase formatted sql

--changeset jbennett:ddl_create_table_organizations labels:release-1.0.0
--comment Release 1.0.0
CREATE TABLE ORGANIZATIONS (
    ID NUMBER PRIMARY KEY NOT NULL,
    NAME VARCHAR2(200),
    INDUSTRY VARCHAR2(400),
    EMPLOYEE_COUNT NUMBER
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

--changeset dzentgraf:ddl_create_table_addresses labels:release-1.1.0
--comment Release 1.1.0
CREATE TABLE ADDRESSES (
    ID NUMBER PRIMARY KEY NOT NULL,
    ADDRESS_LINE_1 VARCHAR2(500),
    CITY VARCHAR2(200),
    STATE VARCHAR2(3),
    ZIP_CODE VARCHAR2(9),
    ORG_ID NUMBER
);
--rollback DROP TABLE ADDRESSES;

--changeset dzentgraf:ddl_create_fk_addresses labels:release-1.1.0
--comment Release 1.1.0
ALTER TABLE ADDRESSES
    ADD CONSTRAINT ORG_FK1
    FOREIGN KEY (ORG_ID)
    REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE ADDRESSES DROP CONSTRAINT ORG_FK1;

--changeset dzentgraf:ddl_create_table_employees labels:release-1.1.0
--comment Release 1.1.0
CREATE TABLE EMPLOYEES (
    ID NUMBER PRIMARY KEY NOT NULL,
    FIRST_NAME VARCHAR2(200),
    LAST_NAME VARCHAR2(200),
    DATE_OF_BIRTH DATE,
    EMAIL_ADDRESS VARCHAR2(200),
    ORG_ID NUMBER
);
--rollback DROP TABLE EMPLOYEES;

--changeset dzentgraf:dml_insert_employees labels:release-1.1.0
--comment Release 1.1.0
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (1, 'Taylor', 'Morgan', TO_DATE('1988-04-15', 'YYYY-MM-DD'), 'redacted@example.com', 1);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (2, 'Jordan', 'Lee', TO_DATE('1992-09-03', 'YYYY-MM-DD'), 'redacted@example.com', 2);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (3, 'Casey', 'Nguyen', TO_DATE('1985-12-22', 'YYYY-MM-DD'), 'redacted@example.com', 3);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (4, 'Riley', 'Patel', TO_DATE('1990-06-11', 'YYYY-MM-DD'), 'redacted@example.com', 4);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (5, 'Avery', 'Chen', TO_DATE('1995-02-27', 'YYYY-MM-DD'), 'redacted@example.com', 5);
--rollback DELETE FROM EMPLOYEES WHERE ID BETWEEN 1 AND 5;

--changeset molivas:ddl_create_fk_employees labels:release-1.2.0
--comment Release 1.2.0
ALTER TABLE EMPLOYEES
    ADD CONSTRAINT ORG_FK2
    FOREIGN KEY (ORG_ID)
    REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE EMPLOYEES DROP CONSTRAINT ORG_FK2;

--changeset molivas:sp_create_getemployeesbyorg labels:release-1.2.0 splitStatements:false runOnChange:true
--comment Release 1.2.0
CREATE OR REPLACE FUNCTION get_employees_by_org(p_org_id IN NUMBER)
RETURN SYS_REFCURSOR
AS
    l_cursor SYS_REFCURSOR;
BEGIN
    OPEN l_cursor FOR
        SELECT e.id, e.first_name, e.last_name, e.date_of_birth
        FROM employees e
        WHERE e.org_id = p_org_id;
    RETURN l_cursor;
END;
--rollback DROP FUNCTION get_employees_by_org;

--changeset jbennett:dml_email_fix labels:jira-1388,release-1.3.0
--comment Release 1.3.0
UPDATE EMPLOYEES SET EMAIL_ADDRESS = 'taylor.morgan2@example.com' WHERE ID = 1;
--rollback UPDATE EMPLOYEES SET EMAIL_ADDRESS = 'redacted@example.com' WHERE ID = 1;

--changeset mikeo:dcl_grant_employee_guest labels:jira-1412,release-1.0.3
--comment Release 1.3.0
GRANT SELECT ON EMPLOYEES TO PUBLIC;
--rollback REVOKE SELECT ON EMPLOYEES FROM PUBLIC;