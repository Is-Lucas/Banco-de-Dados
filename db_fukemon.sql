DROP DATABASE db_fukemon;

CREATE DATABASE db_fukemon;

USE db_fukemon;

CREATE TABLE Regioes (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Clima VARCHAR(50) NOT NULL
);

CREATE TABLE Ginasios (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Cidade VARCHAR(50) NOT NULL,
    Especialidade VARCHAR(50) NOT NULL,
    Regiao_ID INT NOT NULL,
    CONSTRAINT fk_regiao_id FOREIGN KEY (Regiao_ID) REFERENCES Regioes(ID)
);

CREATE TABLE Treinadores (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Idade INT NOT NULL,
    Cidade_Natal VARCHAR(100)
);

CREATE TABLE Lider_Ginasio (
    Treinador_ID INT PRIMARY KEY,
    Data_Assumiu DATE NOT NULL,
    CONSTRAINT fk_lider_ginasio FOREIGN KEY (Treinador_ID) REFERENCES Treinadores(ID)
);

CREATE TABLE Especies (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(300)
);

CREATE TABLE Criaturas (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Apelido VARCHAR(100),
    Nivel INT NOT NULL,
    Pontos_Vida INT NOT NULL,
    Status VARCHAR(20),
    Especie_ID INT NOT NULL,
    Treinador_ID INT NOT NULL,
    CONSTRAINT fk_especies_id FOREIGN KEY (Especie_ID) REFERENCES Especies(ID),
    CONSTRAINT fk_treinador_id FOREIGN KEY (Treinador_ID) REFERENCES Treinadores(ID)
);

CREATE TABLE Golpes (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Tipo_Elemental VARCHAR(50) NOT NULL,
    Poder INT NOT NULL,
    Precisao INT NOT NULL
);

CREATE TABLE Criatura_Golpe (
    Criatura_ID INT NOT NULL,
    Golpe_ID INT NOT NULL,
    PRIMARY KEY (Criatura_ID, Golpe_ID),
    CONSTRAINT fk_criatura_id FOREIGN KEY (Criatura_ID) REFERENCES Criaturas(ID),
    CONSTRAINT fk_golpes_id FOREIGN KEY (Golpe_ID) REFERENCES Golpes(ID)
);

CREATE TABLE Itens (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(300),
    Efeito VARCHAR(200)
);

CREATE TABLE Inventario (
    Treinador_ID INT NOT NULL,
    Item_ID INT NOT NULL,
    Quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (Treinador_ID, Item_ID),
    CONSTRAINT fk_treinadores_id FOREIGN KEY (Treinador_ID)REFERENCES Treinadores(ID),
    CONSTRAINT fk_item_id FOREIGN KEY (Item_ID) REFERENCES Itens(ID)
);


CREATE TABLE Batalhas (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Data_Batalha DATE NOT NULL,
    Resultado VARCHAR(20) NOT NULL,
    Treinador_ID INT NOT NULL,
    Ginasio_ID INT NOT NULL,

    CONSTRAINT fk_treinadorID FOREIGN KEY (Treinador_ID) REFERENCES Treinadores(ID),

    CONSTRAINT fk_ginasio_id FOREIGN KEY (Ginasio_ID)REFERENCES Ginasios(ID)
);



--inserções

INSERT INTO Regioes (Nome, Clima) VALUES
('Kanto', 'Temperado'),
('Johto', 'Subtropical'),
('Hoenn', 'Tropical'),
('Sinnoh', 'Frio'),
('Unova', 'Continental');

INSERT INTO Ginasios (Cidade, Especialidade, Regiao_ID) VALUES
('Pewter', 'Pedra', 1),
('Cerulean', 'Água', 1),
('Violet', 'Voador', 2),
('Rustboro', 'Pedra', 3),
('Snowpoint', 'Gelo', 4);

INSERT INTO Treinadores (Nome, Idade, Cidade_Natal) VALUES
('Ash Ketchum', 15, 'Pallet'),
('Misty', 16, 'Cerulean'),
('Brock', 18, 'Pewter'),
('May', 15, 'Littleroot'),
('Dawn', 16, 'Twinleaf');

INSERT INTO Lider_Ginasio (Treinador_ID, Data_Assumiu) VALUES
(2, '2022-01-15'),
(3, '2021-05-10');

INSERT INTO Especies (Nome, Descricao) VALUES
('Pikachu', 'Pokemon elétrico do tipo rato'),
('Charizard', 'Pokemon dragão de fogo'),
('Squirtle', 'Pokemon tartaruga aquática'),
('Bulbasaur', 'Pokemon planta venenosa'),
('Gengar', 'Pokemon fantasma');

INSERT INTO Criaturas
(Nome, Apelido, Nivel, Pontos_Vida, Status, Especie_ID, Treinador_ID)
VALUES
('Pikachu', 'Pika', 35, 120, 'Normal', 1, 1),
('Charizard', 'Chari', 50, 220, 'Normal', 2, 1),
('Squirtle', 'Shell', 25, 100, 'Normal', 3, 2),
('Bulbasaur', 'Bulba', 20, 95, 'Envenenado', 4, 4),
('Gengar', 'Ghost', 45, 180, 'Normal', 5, 5);

INSERT INTO Criatura_Golpe (Criatura_ID, Golpe_ID) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(1,5),
(2,1);

INSERT INTO Itens (Nome, Descricao, Efeito) VALUES
('Pocao', 'Recupera vida', 'Cura 20 HP'),
('Super Pocao', 'Recupera mais vida', 'Cura 50 HP'),
('Reviver', 'Revive pokemon', 'Recupera metade do HP'),
('Antidoto', 'Cura veneno', 'Remove status'),
('X Ataque', 'Aumenta ataque', 'Buff temporario');

INSERT INTO Inventario (Treinador_ID, Item_ID, Quantidade) VALUES
(1,1,10),
(1,2,5),
(1,3,2),
(2,1,8),
(3,4,6),
(4,5,3),
(5,2,4);

INSERT INTO Batalhas (Data_Batalha, Resultado, Treinador_ID, Ginasio_ID)VALUES 
('2026-01-10', 'Vitoria', 1, 1),
('2026-02-15', 'Vitoria', 1, 2),
('2026-03-20', 'Derrota', 2, 3),
('2026-04-12', 'Vitoria', 4, 4),
('2026-05-08', 'Derrota', 5, 5);

SELECT * FROM Regioes;
SELECT * FROM Ginasios;
SELECT * FROM Treinadores;
SELECT * FROM Lider_Ginasio;
SELECT * FROM Especies;
SELECT * FROM Criaturas;
SELECT * FROM Golpes;
SELECT * FROM Criatura_Golpe;
SELECT * FROM Itens;
SELECT * FROM Inventario;
SELECT * FROM Batalhas;

SELECT
    G.ID,
    G.Cidade,
    G.Especialidade,
    R.Nome AS Regiao
FROM Ginasios G
INNER JOIN Regioes R
ON G.Regiao_ID = R.ID;

SELECT
    C.Nome AS Criatura,
    C.Apelido,
    C.Nivel,
    T.Nome AS Treinador
FROM Criaturas C
INNER JOIN Treinadores T
ON C.Treinador_ID = T.ID;

SELECT
    C.Nome AS Criatura,
    E.Nome AS Especie,
    C.Nivel,
    C.Pontos_Vida
FROM Criaturas C
INNER JOIN Especies E
ON C.Especie_ID = E.ID;

SELECT
    T.Nome,
    T.Idade,
    L.Data_Assumiu
FROM Treinadores T
INNER JOIN Lider_Ginasio L
ON T.ID = L.Treinador_ID;

SELECT
    T.Nome AS Treinador,
    I.Nome AS Item,
    Inv.Quantidade
FROM Inventario Inv
INNER JOIN Treinadores T
ON Inv.Treinador_ID = T.ID
INNER JOIN Itens I
ON Inv.Item_ID = I.ID;


SELECT
    C.Nome AS Criatura,
    G.Nome AS Golpe,
    G.Tipo_Elemental
FROM Criatura_Golpe CG
INNER JOIN Criaturas C
ON CG.Criatura_ID = C.ID
INNER JOIN Golpes G
ON CG.Golpe_ID = G.ID;

SELECT
    B.ID,
    T.Nome AS Treinador,
    G.Cidade AS Ginasio,
    B.Data_Batalha,
    B.Resultado
FROM Batalhas B
INNER JOIN Treinadores T
ON B.Treinador_ID = T.ID
INNER JOIN Ginasios G
ON B.Ginasio_ID = G.ID;

SELECT
    T.Nome,
    COUNT(C.ID) AS Quantidade_Criaturas
FROM Treinadores T
INNER JOIN Criaturas C
ON T.ID = C.Treinador_ID
GROUP BY T.ID, T.Nome;

SELECT
    T.Nome,
    SUM(Iv.Quantidade) AS Total_Itens
FROM Inventario Iv
INNER JOIN Treinadores T
ON Iv.Treinador_ID = T.ID
GROUP BY T.ID, T.Nome;

SELECT
    T.Nome,
    COUNT(B.ID) AS Total_Batalhas
FROM Treinadores T
INNER JOIN Batalhas B
ON T.ID = B.Treinador_ID
GROUP BY T.ID, T.Nome
ORDER BY Total_Batalhas DESC;  