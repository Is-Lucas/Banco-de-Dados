DROP DATABASE IF EXISTS db_palworld;

CREATE DATABASE db_palworld;

USE db_palworld;

CREATE TABLE Regiao(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Clima VARCHAR(100) NOT NULL
);

CREATE TABLE Treinador(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Idade INT NOT NULL,
    Cidade_Natal VARCHAR(100) NOT NULL
);

CREATE TABLE Tipo_Elemental(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Item(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(100) NOT NULL,
    Efeito VARCHAR(100) NOT NULL
);

CREATE TABLE Golpe(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Tipo_Elemental_ID INT NOT NULL,
    Poder INT NOT NULL,
    Precisao INT NOT NULL,
    CONSTRAINT fk_tipo_elemental_golpe
    FOREIGN KEY (Tipo_Elemental_ID) REFERENCES Tipo_Elemental(ID)
);

CREATE TABLE Especie(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Tipo_Elemental_ID INT NOT NULL,
    Descricao VARCHAR(255) NOT NULL,
    CONSTRAINT fk_tipo_elemental_especie
    FOREIGN KEY (Tipo_Elemental_ID) REFERENCES Tipo_Elemental(ID)
);

CREATE TABLE Ginasio(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Cidade VARCHAR(100) NOT NULL,
    Tipo_Elemental_ID INT NOT NULL,
    Regiao_ID INT NOT NULL,
    CONSTRAINT fk_ginasio_tipo_elemental
    FOREIGN KEY (Tipo_Elemental_ID) REFERENCES Tipo_Elemental(ID),
    CONSTRAINT fk_ginasio_regiao
    FOREIGN KEY (Regiao_ID) REFERENCES Regiao(ID)
);

CREATE TABLE Lider_Ginasio(
    Treinador_ID INT PRIMARY KEY,
    Data_Assumiu DATE NOT NULL,
    Ginasio_ID INT NOT NULL UNIQUE,
    CONSTRAINT fk_lider_ginasio_ginasio
    FOREIGN KEY (Ginasio_ID) REFERENCES Ginasio(ID),
    CONSTRAINT fk_lider_ginasio_treinador
    FOREIGN KEY (Treinador_ID) REFERENCES Treinador(ID)
);

CREATE TABLE Treinador_Comum(
    Treinador_ID INT PRIMARY KEY,
    Ranking INT NOT NULL,
    CONSTRAINT fk_treinador_comum_treinador
    FOREIGN KEY (Treinador_ID) REFERENCES Treinador(ID)
);

CREATE TABLE Batalha(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Data_Batalha DATE NOT NULL,
    Resultado CHAR(1) NOT NULL,
    Treinador_ID INT NOT NULL,
    Ginasio_ID INT NOT NULL,
    CONSTRAINT fk_batalha_treinador
    FOREIGN KEY (Treinador_ID) REFERENCES Treinador(ID),
    CONSTRAINT fk_batalha_ginasio
    FOREIGN KEY (Ginasio_ID) REFERENCES Ginasio(ID)
);

CREATE TABLE Criatura(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Apelido VARCHAR(12),
    Nivel INT NOT NULL,
    Vida_Atual INT NOT NULL,
    Especie_ID INT NOT NULL,
    Treinador_ID INT NOT NULL,
    CONSTRAINT fk_criatura_especie
    FOREIGN KEY (Especie_ID) REFERENCES Especie(ID),
    CONSTRAINT fk_criatura_treinador
    FOREIGN KEY (Treinador_ID) REFERENCES Treinador(ID)
);

CREATE TABLE Criatura_Golpe(
    Criatura_ID INT NOT NULL,
    Golpe_ID INT NOT NULL,
    PRIMARY KEY (Criatura_ID, Golpe_ID),
    CONSTRAINT fk_criatura
    FOREIGN KEY (Criatura_ID) REFERENCES Criatura(ID),
    CONSTRAINT fk_golpe
    FOREIGN KEY (Golpe_ID) REFERENCES Golpe(ID)
);

CREATE TABLE Inventario(
    Treinador_ID INT NOT NULL,
    Item_ID INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (Treinador_ID, Item_ID),
    CONSTRAINT fk_inventario_treinador FOREIGN KEY (Treinador_ID) REFERENCES Treinador(ID),
    CONSTRAINT fk_item FOREIGN KEY (Item_ID) REFERENCES Item(ID)
);

USE db_palworld;

-- =========================================================
-- REGIOES
-- =========================================================

INSERT INTO Regiao (Nome, Clima) VALUES
('Ilha Palpagos', 'Tropical'),
('Floresta Verdejante', 'Temperado e úmido'),
('Deserto de Anúbis', 'Árido e quente'),
('Montanhas Congeladas', 'Polar e nevado'),
('Vulcão Obsidiana', 'Quente e vulcânico');


-- =========================================================
-- TREINADORES
-- =========================================================

INSERT INTO Treinador (Nome, Idade, Cidade_Natal) VALUES
('Lucas Almeida', 21, 'Palpagos'),
('Marina Costa', 24, 'Floresta Verdejante'),
('Rafael Santos', 19, 'Planícies Centrais'),
('Beatriz Oliveira', 27, 'Costa Cristalina'),
('Gabriel Souza', 22, 'Deserto de Anúbis'),
('Ana Martins', 20, 'Montanhas Congeladas'),
('Pedro Rodrigues', 31, 'Vulcão Obsidiana'),
('Camila Ferreira', 26, 'Ilha Palpagos'),
('Thiago Barbosa', 23, 'Terras Antigas'),
('Juliana Lima', 28, 'Floresta Sombria'),
('Henrique Carvalho', 35, 'Planícies Centrais'),
('Larissa Gomes', 18, 'Costa Cristalina'),
('Daniel Ribeiro', 25, 'Floresta Verdejante'),
('Sofia Mendes', 22, 'Montanhas Congeladas'),
('André Rocha', 29, 'Deserto de Anúbis'),
('Isabela Dias', 21, 'Ilha Palpagos'),
('Bruno Teixeira', 33, 'Vulcão Obsidiana'),
('Clara Nascimento', 24, 'Terras Antigas'),
('Matheus Correia', 20, 'Planícies Centrais'),
('Valentina Lopes', 27, 'Costa Cristalina');


-- =========================================================
-- TIPOS ELEMENTAIS
-- =========================================================

INSERT INTO Tipo_Elemental (Nome) VALUES
('Neutro'),
('Fogo'),
('Água'),
('Grama'),
('Terra'),
('Elétrico'),
('Gelo'),
('Dragão'),
('Sombrio'),
('Voador');


-- =========================================================
-- ITENS
-- =========================================================

INSERT INTO Item (Nome, Descricao, Efeito) VALUES
('Poção Pequena', 'Recupera uma pequena quantidade de vida.', 'Recupera 50 HP'),
('Poção Média', 'Recupera uma quantidade moderada de vida.', 'Recupera 150 HP'),
('Poção Grande', 'Recupera uma grande quantidade de vida.', 'Recupera 300 HP'),
('Esfera Pal', 'Usada para capturar criaturas.', 'Aumenta a chance de captura'),
('Esfera Mega', 'Esfera aprimorada para capturas difíceis.', 'Alta chance de captura'),
('Esfera Ultra', 'Esfera avançada para criaturas poderosas.', 'Chance muito alta de captura'),
('Fruta de Vida', 'Fruta especial que restaura energia.', 'Recupera 200 HP'),
('Fruta de Força', 'Aumenta temporariamente o poder.', 'Aumenta ataque'),
('Fruta de Defesa', 'Aumenta temporariamente a resistência.', 'Aumenta defesa'),
('Antídoto', 'Remove efeitos de envenenamento.', 'Remove veneno'),
('Remédio Contra Gelo', 'Remove congelamento.', 'Remove congelamento'),
('Remédio Contra Queimadura', 'Remove queimadura.', 'Remove queimadura'),
('Catalisador Elemental', 'Material usado para aprimoramentos.', 'Aumenta dano elemental'),
('Minério Refinado', 'Material raro para equipamentos.', 'Usado em fabricação'),
('Fragmento Antigo', 'Fragmento de origem desconhecida.', 'Material raro'),
('Carne Assada', 'Alimento preparado para criaturas.', 'Recupera energia'),
('Peixe Grelhado', 'Peixe preparado no fogo.', 'Recupera energia'),
('Cogumelo Medicinal', 'Ingrediente com propriedades curativas.', 'Recupera vida'),
('Cristal de Gelo', 'Cristal encontrado em regiões congeladas.', 'Material elemental'),
('Pedra de Fogo', 'Pedra carregada de energia térmica.', 'Material elemental');


-- =========================================================
-- GOLPES
-- =========================================================

INSERT INTO Golpe (Nome, Tipo_Elemental_ID, Poder, Precisao) VALUES
('Investida', 1, 40, 95),
('Golpe Pesado', 1, 70, 85),
('Chama Ardente', 2, 60, 90),
('Explosão Flamejante', 2, 100, 80),
('Jato de Água', 3, 55, 95),
('Canhão de Água', 3, 90, 85),
('Folha Cortante', 4, 50, 95),
('Tempestade de Folhas', 4, 85, 80),
('Tremor', 5, 65, 90),
('Terremoto', 5, 110, 75),
('Choque Elétrico', 6, 55, 95),
('Raio Poderoso', 6, 100, 80),
('Rajada de Gelo', 7, 60, 90),
('Nevasca', 7, 105, 75),
('Sopro de Dragão', 8, 80, 90),
('Impacto Dracônico', 8, 120, 70),
('Esfera Sombria', 9, 65, 90),
('Explosão Sombria', 9, 110, 75),
('Rajada de Vento', 10, 55, 95),
('Furacão', 10, 100, 80),
('Mordida', 9, 60, 90),
('Garra Flamejante', 2, 75, 85),
('Onda Congelante', 7, 80, 85),
('Lança Terrestre', 5, 90, 80),
('Raio Celestial', 6, 115, 70);


-- =========================================================
-- ESPECIES
-- =========================================================

INSERT INTO Especie (Nome, Tipo_Elemental_ID, Descricao) VALUES
('Lamball', 1, 'Criatura dócil coberta por uma lã macia e resistente.'),
('Cattiva', 1, 'Criatura felina pequena e muito útil para trabalhos.'),
('Chikipi', 1, 'Pequena criatura semelhante a uma ave doméstica.'),
('Foxparks', 2, 'Pequena criatura de fogo capaz de lançar chamas.'),
('Rooby', 2, 'Criatura semelhante a um pequeno marsupial flamejante.'),
('Pengullet', 3, 'Criatura aquática semelhante a um pequeno pinguim.'),
('Fuack', 3, 'Criatura aquática ágil e bastante curiosa.'),
('Lifmunk', 4, 'Criatura pequena que utiliza energia vegetal.'),
('Tanzee', 4, 'Criatura semelhante a um macaco com habilidades vegetais.'),
('Digtoise', 5, 'Grande criatura semelhante a uma tartaruga terrestre.'),
('Fuddler', 5, 'Criatura pequena especializada em escavações.'),
('Sparkit', 6, 'Criatura elétrica capaz de gerar pequenas descargas.'),
('Jolthog', 6, 'Criatura elétrica semelhante a um pequeno ouriço.'),
('Chillet', 7, 'Criatura veloz de gelo que habita regiões frias.'),
('Pengking', 3, 'Criatura aquática poderosa encontrada em regiões geladas.'),
('Nitewing', 10, 'Grande criatura voadora usada para viagens aéreas.'),
('Vanwyrm', 9, 'Criatura voadora de aparência sombria.'),
('Elizabee', 4, 'Criatura associada a colmeias e ambientes florestais.'),
('Mammorest', 4, 'Grande criatura herbívora com enorme força física.'),
('Relaxaurus', 3, 'Criatura aquática de grande porte e comportamento tranquilo.'),
('Arsox', 2, 'Criatura semelhante a um cervo com poderes de fogo.'),
('Reindrix', 7, 'Criatura semelhante a uma rena adaptada ao frio extremo.'),
('Anubis', 5, 'Criatura poderosa associada às antigas ruínas do deserto.'),
('Grizzbolt', 6, 'Grande criatura elétrica extremamente poderosa.'),
('Jetragon', 8, 'Criatura lendária com aparência de dragão tecnológico.');


-- =========================================================
-- GINASIOS
-- =========================================================

INSERT INTO Ginasio (Cidade, Tipo_Elemental_ID, Regiao_ID) VALUES
('Palpagos Central', 1, 1),
('Vila Verde', 4, 2),
('Cidade de Anúbis', 5, 3),
('Porto Congelado', 7, 4),
('Cidade Obsidiana', 2, 5),
('Vila das Marés', 3, 1),
('Capital Central', 1, 2),
('Ruínas Antigas', 5, 3),
('Porto Cristalino', 3, 4),
('Floresta Noturna', 9, 5);


-- =========================================================
-- LIDERES DE GINASIO
-- =========================================================

INSERT INTO Lider_Ginasio (Treinador_ID, Data_Assumiu, Ginasio_ID) VALUES
(1, '2020-02-15', 1),
(2, '2021-06-10', 2),
(3, '2019-08-21', 3),
(4, '2022-01-12', 4),
(5, '2018-04-05', 5),
(6, '2021-11-30', 6),
(7, '2020-09-17', 7),
(8, '2019-12-03', 8),
(9, '2022-05-28', 9),
(10, '2020-07-14', 10);


-- =========================================================
-- TREINADORES COMUNS
-- =========================================================

INSERT INTO Treinador_Comum (Treinador_ID, Ranking) VALUES
(11, 1),
(12, 2),
(13, 4),
(14, 5),
(15, 6),
(16, 8),
(17, 9),
(18, 10),
(19, 3),
(20, 7);

-- =========================================================
-- BATALHAS
-- =========================================================

INSERT INTO Batalha (Data_Batalha, Resultado, Treinador_ID, Ginasio_ID) VALUES
('2024-01-10', 'V', 11, 1),
('2024-01-15', 'D', 20, 2),
('2024-01-21', 'V', 19, 3),
('2024-02-03', 'V', 11, 4),
('2024-02-14', 'D', 12, 5),
('2024-02-20', 'V', 11, 6),
('2024-03-01', 'V', 13, 7),
('2024-03-09', 'D', 15, 8),
('2024-03-18', 'V', 12, 9),
('2024-03-25', 'V', 13, 10),
('2024-04-02', 'V', 14, 1),
('2024-04-12', 'D', 15, 2),
('2024-04-20', 'V', 16, 3),
('2024-05-05', 'V', 17, 4),
('2024-05-17', 'D', 18, 5),
('2024-05-29', 'V', 19, 6),
('2024-06-04', 'V', 11, 7),
('2024-06-16', 'D', 20, 8),
('2024-06-28', 'V', 12, 9),
('2024-07-07', 'V', 13, 10),
('2024-07-18', 'D', 14, 1),
('2024-07-30', 'V', 14, 2),
('2024-08-08', 'V', 15, 3),
('2024-08-19', 'D', 16, 4),
('2024-09-01', 'V', 17, 5),
('2024-09-13', 'V', 18, 6),
('2024-09-25', 'D', 19, 7),
('2024-10-04', 'V', 19, 8),
('2024-10-15', 'V', 20, 9),
('2024-10-27', 'D', 12, 10);


-- =========================================================
-- CRIATURAS
-- =========================================================

INSERT INTO Criatura
(Apelido, Nivel, Vida_Atual, Especie_ID, Treinador_ID) VALUES
('Lãzinha', 12, 180, 1, 1),
('Mimi', 18, 250, 2, 1),
('Foguinho', 15, 210, 4, 2),
('Chamas', 24, 380, 5, 2),
('Pingu', 10, 150, 6, 3),
('Marujo', 21, 330, 7, 3),
('Folhinha', 14, 220, 8, 4),
('Tanzito', 27, 420, 9, 4),
('Tartaruga', 32, 600, 10, 5),
('Escavador', 20, 310, 11, 5),
('Faísca', 17, 260, 12, 6),
('Choquinho', 25, 410, 13, 6),
('Gelinho', 19, 300, 14, 7),
('Pingu Rei', 30, 520, 15, 7),
('Asa Negra', 35, 580, 17, 8),
('Ventania', 28, 470, 16, 8),
('Abelha', 31, 500, 18, 9),
('Gigante', 40, 850, 19, 9),
('Lagartão', 26, 430, 20, 10),
('Cervo Fogo', 22, 360, 21, 10),
('Rena Azul', 29, 490, 22, 11),
('Anúbis', 45, 950, 23, 11),
('Tempestade', 48, 1100, 24, 12),
('Dragão', 50, 1200, 25, 12),
('Lamball II', 16, 230, 1, 13),
('Cattiva II', 20, 290, 2, 13),
('Raposa', 23, 350, 4, 14),
('Gelo', 34, 570, 14, 14),
('Terra', 37, 700, 10, 15),
('Raio', 33, 610, 13, 15),
('Sombra', 38, 720, 17, 16),
('Voador', 41, 780, 16, 16),
('Folha', 25, 390, 9, 18),
('Pedregulho', 30, 540, 11, 18),
('Peixinho', 18, 270, 7, 19),
('Maré', 36, 650, 20, 19),
('Brasa', 29, 480, 21, 20),
('Congelado', 39, 730, 22, 20),
('Anúbis Jr', 28, 450, 23, 3),
('Trovão', 43, 900, 24, 7);


-- =========================================================
-- RELAÇÃO CRIATURA x GOLPE
-- =========================================================

INSERT INTO Criatura_Golpe VALUES
(1, 1),
(1, 2),
(1, 7),

(2, 1),
(2, 21),
(2, 19),

(3, 3),
(3, 22),
(3, 19),

(4, 3),
(4, 4),
(4, 22),

(5, 5),
(5, 19),
(5, 1),

(6, 5),
(6, 6),
(6, 23),

(7, 7),
(7, 8),
(7, 1),

(8, 7),
(8, 8),
(8, 24),

(9, 9),
(9, 10),
(9, 2),

(10, 9),
(10, 24),
(10, 1),

(11, 11),
(11, 12),
(11, 1),

(12, 11),
(12, 12),
(12, 25),

(13, 13),
(13, 23),
(13, 19),

(14, 13),
(14, 14),
(14, 23),

(15, 17),
(15, 19),
(15, 21),

(16, 19),
(16, 20),
(16, 1),

(17, 7),
(17, 17),
(17, 21),

(18, 7),
(18, 8),
(18, 10),

(19, 5),
(19, 6),
(19, 2),

(20, 3),
(20, 22),
(20, 19),

(21, 13),
(21, 14),
(21, 1),

(22, 9),
(22, 10),
(22, 24),

(23, 11),
(23, 12),
(23, 25),

(24, 15),
(24, 16),
(24, 25),

(25, 1),
(25, 2),

(26, 1),
(26, 21),

(27, 3),
(27, 22),

(28, 13),
(28, 14),

(29, 9),
(29, 10),

(30, 11),
(30, 12),

(31, 17),
(31, 18),

(32, 19),
(32, 20),

(33, 7),
(33, 8),

(34, 9),
(34, 24),

(35, 5),
(35, 6),

(36, 5),
(36, 6),
(36, 15),

(37, 3),
(37, 4),
(37, 22),

(38, 13),
(38, 14),
(38, 23),

(39, 9),
(39, 10),
(39, 24),

(40, 11),
(40, 12),
(40, 25);


-- =========================================================
-- INVENTARIOS
-- =========================================================

INSERT INTO Inventario VALUES
(1, 1, 15),
(1, 4, 30),
(1, 5, 12),
(1, 16, 20),

(2, 2, 10),
(2, 4, 25),
(2, 8, 8),
(2, 17, 15),

(3, 1, 20),
(3, 4, 40),
(3, 7, 10),
(3, 10, 5),

(4, 2, 15),
(4, 5, 20),
(4, 9, 7),
(4, 18, 12),

(5, 3, 8),
(5, 4, 35),
(5, 8, 15),
(5, 20, 10),

(6, 1, 18),
(6, 4, 25),
(6, 11, 8),
(6, 19, 14),

(7, 3, 12),
(7, 5, 18),
(7, 12, 6),
(7, 20, 20),

(8, 2, 14),
(8, 4, 30),
(8, 6, 5),
(8, 13, 8),

(9, 3, 10),
(9, 5, 22),
(9, 9, 10),
(9, 14, 15),

(10, 1, 25),
(10, 4, 45),
(10, 6, 8),
(10, 15, 5),

(11, 3, 20),
(11, 5, 25),
(11, 8, 12),
(11, 14, 18),

(12, 2, 12),
(12, 4, 35),
(12, 7, 15),
(12, 17, 20),

(13, 1, 18),
(13, 5, 20),
(13, 10, 8),
(13, 18, 15),

(14, 2, 15),
(14, 4, 28),
(14, 11, 10),
(14, 19, 20),

(15, 3, 10),
(15, 6, 12),
(15, 12, 8),
(15, 20, 25),

(16, 1, 22),
(16, 4, 40),
(16, 5, 10),
(16, 13, 12),

(18, 2, 18),
(18, 5, 15),
(18, 9, 10),
(18, 14, 20),

(19, 1, 20),
(19, 4, 30),
(19, 7, 12),
(19, 17, 18),

(20, 3, 10),
(20, 5, 20),
(20, 12, 8),
(20, 19, 15);




SELECT Ranking, Nome FROM Treinador_Comum JOIN Treinador ON Treinador_ID = ID ORDER BY Ranking ASC;


SELECT Nome AS "Nome do Treinador", Apelido AS PALS FROM Treinador JOIN Criatura ON Treinador_ID = Treinador.ID ORDER BY Nome ASC;

SELECT
   Ranking, ID, Nome
FROM
   Treinador_Comum
JOIN
   Treinador ON Treinador_ID = ID
ORDER BY
   Ranking;

SELECT Nome, Apelido
FROM Treinador
JOIN Criatura ON Treinador_ID = Treinador.ID
ORDER BY Nome;

SELECT Nome AS "Nome do Treinador", Apelido AS Pals
FROM Treinador
JOIN Criatura ON Treinador_ID = Treinador.ID
ORDER BY Nome;

SELECT nome, idade FROM Treinador WHERE Nome LIKE 'Camila%';

SELECT nome, idade FROM Treinador WHERE ID = 8;

SELECT Nome AS Treinador, GROUP_CONCAT(Apelido SEPARATOR " - ") AS Criaturas
FROM Treinador
JOIN Criatura ON Treinador_ID = Treinador.ID
GROUP BY Nome
ORDER BY Nome;


