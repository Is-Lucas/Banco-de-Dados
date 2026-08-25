DROP DATABASE db_exercicio2;

CREATE DATABASE db_exercicio2;

USE db_exercicio2;

CREATE TABLE Autores(
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Nascionalidade VARCHAR(100) NOT NULL,
    Data_nasc DATETIME
);

CREATE TABLE Livros(
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Ano_publicacao DATETIME NOT NULL,
    Num_pag INT NOT NULL
);


CREATE TABLE Relacao (
    Autor_ID INT,
    Livro_ID INT,
    PRIMARY KEY (Autor_ID, Livro_ID),
    CONSTRAINT fk_autor FOREIGN KEY (Autor_ID) REFERENCES Autores(ID),
    CONSTRAINT fk_livro FOREIGN KEY (Livro_ID) REFERENCES Livros(ID)
);

-- Autores
INSERT INTO Autores (Nome, Nascionalidade, Data_nasc) VALUES
('Machado de Assis', 'Brasileira', '1839-06-21'),
('José de Alencar', 'Brasileira', '1829-05-01'),
('J. K. Rowling', 'Britânica', '1965-07-31'),
('George R. R. Martin', 'Americana', '1948-09-20');

-- Livros
INSERT INTO Livros (Titulo, Ano_publicacao, Num_pag) VALUES
('Dom Casmurro', '1899-01-01', 256),
('O Guarani', '1857-01-01', 320),
('Harry Potter e a Pedra Filosofal', '1997-06-26', 223),
('A Guerra dos Tronos', '1996-08-06', 694),
('Livro Colaborativo', '2024-01-01', 500);

-- Relação Autor x Livro
INSERT INTO Relacao (Autor_ID, Livro_ID) VALUES
(1, 1), -- Machado de Assis -> Dom Casmurro
(2, 2), -- José de Alencar -> O Guarani
(3, 3), -- J.K. Rowling -> Harry Potter
(4, 4), -- George R.R. Martin -> A Guerra dos Tronos
(1, 5), -- Machado de Assis -> Livro Colaborativo
(2, 5); -- José de Alencar -> Livro Colaborativo

SELECT * FROM Autores;
SELECT * FROM Livros;
SELECT * FROM Relacao;
