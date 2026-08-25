-- Apaga o banco de dados "db_quitanda" caso ele já exista
DROP DATABASE db_quitanda;

-- Cria um novo banco de dados chamado "db_quitanda"
CREATE DATABASE db_quitanda;

-- Seleciona o banco de dados que será utilizado nas próximas operações
USE db_quitanda;

-- Cria a tabela "Categoria"
CREATE TABLE Categoria(

    -- Cria a coluna ID como chave primária da tabela
    -- AUTO_INCREMENT faz o valor aumentar automaticamente a cada novo registro
    -- NOT NULL torna o preenchimento obrigatório
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,

    -- Cria a coluna Nome para armazenar o nome da categoria
    -- VARCHAR(100) permite até 100 caracteres
    -- NOT NULL torna o campo obrigatório
    Nome VARCHAR(100) NOT NULL
);

-- Cria a tabela "Produto"
CREATE TABLE Produto(

    -- Chave primária da tabela Produto
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,

    -- Armazena o nome do produto
    Nome VARCHAR(100) NOT NULL,

    -- Armazena o preço do produto
    -- DECIMAL(6,2) permite até 6 dígitos, sendo 2 após a vírgula
    Preco DECIMAL(6,2),

    -- Armazena o ID da categoria à qual o produto pertence
    Categoria_ID INT NOT NULL,

    -- Cria uma chave estrangeira chamada fk_produto_categoria
    -- Ela relaciona a coluna Categoria_ID da tabela Produto
    -- com a coluna ID da tabela Categoria
    CONSTRAINT fk_produto_categoria
    FOREIGN KEY (Categoria_ID)
    REFERENCES Categoria(ID)
);

-- Insere duas categorias na tabela Categoria
INSERT INTO Categoria(Nome) VALUES
("Limpeza"),    -- Categoria de produtos de limpeza
("Frutas");     -- Categoria de frutas

-- Insere produtos na tabela Produto
INSERT INTO Produto(Nome, Preco, Categoria_ID) VALUES

-- Produto "Veja Multiuso" com preço R$ 15,73 pertencente à categoria 1 (Limpeza)
("Veja Multiuso", 15.73, 1),

-- Produto "Manga Palmer" com preço R$ 8,16 pertencente à categoria 2 (Frutas)
("Manga Palmer", 8.16, 2),

-- Produto "Maçã Turma da Mônica" com preço R$ 7,09 pertencente à categoria 2 (Frutas)
("Maçã Turma da Mônica", 7.09, 2);

-- Exibe todos os registros da tabela Categoria
SELECT * FROM Categoria;