DROP DATABASE db_exercicio1;

CREATE DATABASE db_exercicio1;

USE db_exercicio1;

CREATE TABLE Categoria(
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR (300)
);

CREATE TABLE Postagem(
ID INT PRIMARY KEY AUTO_INCREMENT NOT NUll,
Titulo VARCHAR(100) NOT NULL,
Conteudo VARCHAR (500) NOT NULL,
Data_postagem TIMESTAMP NOT NULL,
Categoria_ID INT,
CONSTRAINT fk_categoria_postagem FOREIGN KEY (Categoria_ID) REFERENCES Categoria(ID)
);

-- Inserindo categorias
INSERT INTO Categoria (Nome, Descricao) VALUES
('Tecnologia', 'Notícias e novidades sobre tecnologia'),
('Esportes', 'Conteúdo relacionado a esportes'),
('Educação', 'Artigos e dicas sobre educação'),
('Entretenimento', 'Filmes, séries e cultura pop');

-- Inserindo postagens
INSERT INTO Postagem (Titulo, Conteudo, Data_postagem, Categoria_ID) VALUES
(
    'Lançamento de novo smartphone',
    'Uma grande empresa anunciou um novo smartphone com recursos inovadores.',
    CURRENT_TIMESTAMP(),
    1
),

(
    'Final do campeonato estadual',
    'O time da casa conquistou o título após uma partida emocionante.',
   CURRENT_TIMESTAMP(),
    2
),

(
    'Dicas para estudar programação',
    'Confira algumas estratégias para melhorar seu aprendizado em programação.',
    CURRENT_TIMESTAMP(),
    3
),

(   
    'Nova série faz sucesso no streaming',
    'A produção alcançou milhões de visualizações na primeira semana.',
    CURRENT_TIMESTAMP(),
    4
),
(
    'Inteligência Artificial nas empresas',
'Cada vez mais empresas utilizam IA para automatizar processos.',
CURRENT_TIMESTAMP(),
1
);

SHOW TABLES;
SELECT * FROM Categoria;
SELECT * FROM Postagem;
