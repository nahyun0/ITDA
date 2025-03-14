CREATE DATABASE itda_db;
USE itda_db;

CREATE TABLE users (
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    password VARCHAR(255) NOT NULL UNIQUE
);
DROP TABLE users;
DESC users;

SELECT User, Host FROM mysql.user;

SELECT * FROM users;

