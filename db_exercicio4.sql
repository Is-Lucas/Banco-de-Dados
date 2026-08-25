DROP DATABASE db_exercicio4;

CREATE DATABASE db_exercicio4;

USE db_exercicio4;

CREATE TABLE Categoria(
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR (300)
);

CREATE TABLE Produto(
ID INT PRIMARY KEY AUTO_INCREMENT NOT NUll,
Nome VARCHAR(100) NOT NULL,
Preco INT NOT NULL,
Tamanho VARCHAR(50) NOT NULL,
Categoria_ID INT,
Data_cadastro TIMESTAMP NOT NULL,
CONSTRAINT fk_categoria FOREIGN KEY (Categoria_ID) REFERENCES Categoria(ID)
);

-- Categorias
INSERT INTO Categoria (Nome, Descricao) VALUES
('Camisetas', 'Camisetas masculinas e femininas'),
('Calcas', 'Calcas jeans e sociais'),
('Vestidos', 'Vestidos casuais e formais'),
('Calcados', 'Tenis, sapatos e sandalias'),
('Acessorios', 'Bolsas, cintos e bonés');

-- Produtos
INSERT INTO Produto 
(Nome, Preco, Tamanho, Categoria_ID, Data_cadastro) 
VALUES
('Camiseta Basica Branca', 49, 'M', 1, NOW()),
('Camiseta Estampada', 69, 'G', 1, NOW()),
('Calca Jeans Skinny', 129, '42', 2, NOW()),
('Calca Social Preta', 149, '40', 2, NOW()),
('Vestido Floral', 179, 'P', 3, NOW()),
('Vestido Longo Elegante', 259, 'M', 3, NOW()),
('Tenis Esportivo', 299, '41', 4, NOW()),
('Sandalia Feminina', 119, '37', 4, NOW()),
('Bolsa de Couro', 199, 'Unico', 5, NOW()),
('Bone Aba Curva', 59, 'Unico', 5, NOW());

SELECT * FROM Categoria;

SELECT * FROM Produto;

SELECT
    p.ID,
    p.Nome AS Produto,
    p.Preco,
    p.Tamanho,
    c.Nome AS Categoria,
    p.Data_cadastro
FROM Produto p
INNER JOIN Categoria c
    ON p.Categoria_ID = c.ID;
