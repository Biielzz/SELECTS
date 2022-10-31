CREATE DATABASE Projeto
GO
USE Projeto
GO

CREATE TABLE users (
id						INT	      IDENTITY(1, 1)           NOT NULL,
name				 VARCHAR(45)                           NOT NULL,
username			 VARCHAR(45)   UNIQUE                  NOT NULL,
password			 VARCHAR(45)  DEFAULT('123mudar')      NOT NULL,
email				 VARCHAR(45)		                   NOT NULL
PRIMARY KEY(id)
)
GO

CREATE TABLE projects (
id						INT	    IDENTITY(10001, 1)	        NOT NULL,
name				 VARCHAR(45)                            NOT NULL,
description			VARCHAR(45)                             NULL,
date				   DATE 	CHECK(date > '01/09/2014')	NOT NULL
PRIMARY KEY(id)
)

GO
CREATE TABLE users_projects (
id_users			    INT                                  NOT NULL,
id_projects		        INT                                  NOT NULL
PRIMARY KEY(id_users,id_projects)
FOREIGN KEY(id_users) REFERENCES users(id),
FOREIGN KEY(id_projects) REFERENCES projects(id)
)

GO
ALTER TABLE users
ALTER COLUMN username VARCHAR (10)  NOT NULL
GO
ALTER TABLE users
ALTER COLUMN password VARCHAR (8)  NOT NULL
GO

SELECT*FROM users
SELECT*FROM projects
SELECT*FROM users_projects


INSERT INTO users ( name, username, password, email)
VALUES('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com')

INSERT INTO users ( name, username, password, email)
VALUES('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')

INSERT INTO users ( name, username, password, email)
VALUES('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com')

INSERT INTO users ( name, username, password, email)
VALUES('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com')

INSERT INTO users ( name, username, password, email)
VALUES('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')
GO

INSERT INTO projects( name, description, date)
VALUES('Re-folha','Refatoração das Folhas','05/09/2014')

INSERT INTO projects( name, description, date)
VALUES('Manutenção PCs','Manutenção PCs','06/09/2014')

INSERT INTO projects( name, description, date)
VALUES('Auditoria', NULL,'07/09/2014')



INSERT INTO users_projects (id_users, id_projects)
VALUES(1, 10001)

INSERT INTO users_projects (id_users, id_projects)
VALUES(5, 10001)

INSERT INTO users_projects (id_users, id_projects)
VALUES(3, 10003)

INSERT INTO users_projects (id_users, id_projects)
VALUES(4, 10002)

INSERT INTO users_projects (id_users, id_projects)
VALUES(2, 10002)


UPDATE projects
SET date = '12/09/2014'
WHERE name = 'Manutenção PCs'

UPDATE users
SET username = 'Rh_cido'
WHERE name = 'Aparecido'

UPDATE users
SET password = '888@*'
WHERE username = 'Rh_maria' AND password = '123mudar'

DELETE users_projects
WHERE id_users = 2

SELECT id, name, email, username,
CASE When password <> '123mudar'
Then '********'
Else password
end AS password
FROM users

SELECT name, description, date
FROM projects
Where id IN (
SELECT id_projects FROM users_projects
WHERE id_users IN (
select id from users
where email = 'aparecido@empresa.com'))

SELECT name, email 
FROM users
WHERE id IN (
SELECT id_users FROM users_projects
WHERE id_projects IN (
SELECT id FROM projects
WHERE name = 'Auditoria'))

SELECT name, description, date, DATEDIFF(
DAY,date,'16/09/2014') * 79.85 AS custo_total
FROM projects
WHERE name LIKE '%Manutenção%'