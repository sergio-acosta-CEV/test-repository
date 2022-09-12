/* Setting up database */
DROP DATABASE IF EXISTS prod;
CREATE DATABASE prod;
USE prod;
CREATE TABLE user
(
    id       BIGINT AUTO_INCREMENT NOT NULL,
    email    VARCHAR(70) UNIQUE    NOT NULL,
    password VARCHAR(100)          NOT NULL,
    PRIMARY KEY (id),
    INDEX (email)
);

/* Create TEST DB */
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;

/* Mirror the structure in a database for tests */
USE test;
CREATE TABLE user LIKE prod.user;

/* Users to access the databases with limited permissions */
DROP USER IF EXISTS 'dbuser';
DROP USER IF EXISTS 'testuser';
CREATE USER 'dbuser' IDENTIFIED BY 'dbpassword';
CREATE USER 'testuser' IDENTIFIED BY 'testpassword';
GRANT SELECT, INSERT, UPDATE ON prod.* TO 'dbuser';
GRANT DELETE ON prod.connection TO 'dbuser';
GRANT SELECT, INSERT, UPDATE, DELETE ON test.* TO 'testuser';