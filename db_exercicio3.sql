DROP DATABASE db_exercicio3;

CREATE DATABASE db_exercicio3;

USE db_exercicio3;

CREATE TABLE Aluno(
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Data_nasc DATETIME
);

CREATE TABLE Nivel (
ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Nivel VARCHAR(13)
);


CREATE TABLE Cursos(
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Idioma VARCHAR(100) NOT NULL,
    Nivel_id INT NOT NULL,
    Carga_horaria INT NOT NULL,
    CONSTRAINT fk_nivel FOREIGN KEY (Nivel_id) REFERENCES Nivel(ID)
);


CREATE TABLE Relacao (
    Aluno_ID INT,
    Curso_ID INT,
    Matricula TIMESTAMP NOT NULL,
    PRIMARY KEY (Aluno_ID, Curso_ID),
    CONSTRAINT fk_aluno FOREIGN KEY (Aluno_ID) REFERENCES Aluno(ID),
    CONSTRAINT fk_curso FOREIGN KEY (Curso_ID) REFERENCES Cursos(ID)
 
);

-- Níveis
INSERT INTO Nivel (Nivel) VALUES
('Basico'),
('Intermediario'),
('Avancado');

-- Alunos
INSERT INTO Aluno (Nome, Email, Data_nasc) VALUES
('Joao Silva', 'joao@email.com', '2000-05-15'),
('Maria Souza', 'maria@email.com', '1999-08-20'),
('Pedro Santos', 'pedro@email.com', '2001-12-10'),
('Ana Oliveira', 'ana@email.com', '2002-03-25');

-- Cursos
INSERT INTO Cursos (Idioma, Nivel_id, Carga_horaria) VALUES
('Ingles', 1, 60),
('Espanhol', 2, 80),
('Frances', 3, 100),
('Alemao', 1, 70);

-- Relação Aluno x Curso
INSERT INTO Relacao (Aluno_ID, Curso_ID, Matricula) VALUES
(1, 1, NOW()),
(1, 2, NOW()),
(2, 1, NOW()),
(2, 3, NOW()),
(3, 4, NOW()),
(4, 2, NOW());


SELECT * FROM Aluno;
SELECT * FROM Cursos;
SELECT * FROM Relacao;


SELECT 
    batata.Nome AS Aluno,
    c.Idioma AS Curso,
    r.Matricula
FROM Relacao r
INNER JOIN Aluno batata
    ON r.Aluno_ID = batata.ID
INNER JOIN Cursos c
    ON r.Curso_ID = c.ID;