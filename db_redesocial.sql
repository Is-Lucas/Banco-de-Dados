DROP DATABASE db_redesocial;

CREATE DATABASE db_redesocial;

USE db_redesocial;

CREATE TABLE usuario(
ID INT PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(120),
Email VARCHAR(100),
Senha_hash VARCHAR(255),
Foto_perfil VARCHAR (255),
Bio TEXT(300),
Data_criacao DATETIME
);

CREATE TABLE postagem(
ID INT PRIMARY KEY AUTO_INCREMENT,
Usuario_id INT NOT NULL,
Conteudo TEXT(1000),
Midia_url VARCHAR(255),
Data_criacao DATETIME,
CONSTRAINT fk_postagem_usuario FOREIGN KEY (Usuario_id) REFERENCES usuario(ID)
);

CREATE TABLE seguidor(
    Seguidor_ID INT,
    Seguido_ID INT,
    Status VARCHAR(10),
    Data_seguido DATETIME,
    FOREIGN CONSTRAINT fk_seguidor_usuario KEY (Seguidor_ID) REFERENCES Usuario(ID),
    CONSTRAINT fk_seguido_usuario FOREIGN KEY (Seguido_ID) REFERENCES Usuario(ID)

);

INSERT INTO usuario(Nome, Email, Bio) VALUES
("Isaias","Isaias@email.com","Sou bonito, sou gostoso, jogo bola e danço"),
("Lucas","Lucas@email.com","Sou bonito, sou gostoso, jogo bola e danço"),
("Ana","ana@email.com","ELA/DELA"),
("Maria","maria@email.com","SE PALMEIRAS");

INSERT INTO postagem(Usuario_id, Conteudo)VALUES
(4,"Oportunidade de emprego única!!"),
(2,"Eai meu chapa!"),
(4,"I GOSTH THE DA COOL"),
(3,"Jachu Paypal"),
(1,"Banco de dados é dificil"),
(1,"DROP DATABASE ALL"),
(2,"Hoje tem show do MATUE"),
(3,"Batendo em Mainha di murro");


SELECT Usuario_id, Conteudo FROM postagem;




x


