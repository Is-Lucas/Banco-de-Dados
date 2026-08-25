DROP DATABASE db_lojaroupa;

CREATE DATABASE db_lojaroupa;

USE db_lojaroupa;

CREATE TABLE Categoria(
    ID INT PRIMARY KEY  AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(100)
);

CREATE TABLE Produto(
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(100) NOT NULL, 
    Preco DECIMAL(6,2) NOT NULL,
    Tamanho VARCHAR(3) NOT NULL,
    Data_cadastro TIMESTAMP NOT NULL,
    Categoria_id INT,
    CONSTRAINT fk_categoria_produto FOREIGN KEY (Categoria_id) REFERENCES Categoria(ID)
);

-- Inserindo categorias
INSERT INTO Categoria (Nome, Descricao) VALUES
('Camisetas', 'Camisetas masculinas e femininas'),
('Calçados', 'Tênis, sapatos e sandálias'),
('Acessórios', 'Bonés, cintos e mochilas'),
('Calças', 'Calças jeans e sociais'),
('Jaquetas', 'Jaquetas para diversas ocasiões');

-- Inserindo produtos
INSERT INTO Produto (Nome, Preco, Tamanho, Data_cadastro, Categoria_id) VALUES
('Camiseta Básica Branca', 49.90, 'M', CURRENT_TIMESTAMP() , 1),
('Camiseta Estampada', 69.90, 'G', CURRENT_TIMESTAMP(), 1),
('Tênis Esportivo', 299.90, '42', CURRENT_TIMESTAMP(), 2),
('Sapato Social', 199.90, '40', CURRENT_TIMESTAMP(), 2),
('Boné Preto', 39.90, 'UNI', CURRENT_TIMESTAMP(), 3),
('Mochila Escolar', 129.90, 'UNI', CURRENT_TIMESTAMP(), 3),
('Calça Jeans Slim', 149.90, '42', CURRENT_TIMESTAMP(), 4),
('Calça Social', 179.90, '40', CURRENT_TIMESTAMP(), 4),
('Jaqueta de Couro', 399.90, 'G', CURRENT_TIMESTAMP(), 5),
('Jaqueta Corta-Vento', 249.90, 'M', CURRENT_TIMESTAMP(), 5);

SELECT * FROM Categoria;
SELECT * FROM Produto;

SELECT * FROM Produto WHERE Categoria_ID = 1;
SELECT * FROM Produto WHERE Categoria_ID = 2;
SELECT * FROM Produto WHERE Categoria_ID = 3;
SELECT * FROM Produto WHERE Categoria_ID = 4;
SELECT * FROM Produto WHERE Categoria_ID = 5;

