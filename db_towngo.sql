DROP DATABASE IF EXISTS db_towngo;

CREATE DATABASE db_towngo;

USE db_towngo;

CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATETIME NOT NULL
);

CREATE TABLE Motorista (
    id_motorista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cnh VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATETIME NOT NULL,
    status ENUM('ATIVO','INATIVO') NOT NULL
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tarifa_base DECIMAL(10,2) NOT NULL,
    valor_km DECIMAL(10,2) NOT NULL,
    valor_minuto DECIMAL(10,2) NOT NULL
);

CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_motorista INT NOT NULL,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    cor VARCHAR(30),
    ano INT,
    capacidade_passageiros INT,
    CONSTRAINT fk_veiculo_motorista FOREIGN KEY (id_motorista) REFERENCES Motorista(id_motorista)
);

CREATE TABLE Forma_Pagamento (
    id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo ENUM('CREDITO','DEBITO','PIX','DINHEIRO') NOT NULL,
    descricao VARCHAR(100),
    identificador VARCHAR(100),

    CONSTRAINT fk_forma_pagamento_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES Usuario(id_usuario)
);

CREATE TABLE Corrida (
    id_corrida INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_motorista INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_categoria INT NOT NULL,
    data_hora_solicitacao DATETIME NOT NULL,
    data_hora_inicio DATETIME,
    data_hora_termino DATETIME,
    endereco_origem VARCHAR(255) NOT NULL,
    endereco_destino VARCHAR(255) NOT NULL,
    distancia DECIMAL(8,2),
    valor_total DECIMAL(10,2),
    status ENUM('SOLICITADA','ACEITA','EM_ANDAMENTO','FINALIZADA','CANCELADA') NOT NULL,

    CONSTRAINT fk_corrida_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    CONSTRAINT fk_corrida_motorista FOREIGN KEY (id_motorista) REFERENCES Motorista(id_motorista),
    CONSTRAINT fk_corrida_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    CONSTRAINT fk_corrida_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_corrida INT UNIQUE NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor_pago DECIMAL(10,2),
    data_hora_pagamento DATETIME,
    status ENUM('PENDENTE','PAGO','CANCELADO'),

    CONSTRAINT fk_pagamento_corrida FOREIGN KEY (id_corrida) REFERENCES Corrida(id_corrida),
    CONSTRAINT fk_pagamento_forma_pagamento FOREIGN KEY (id_forma_pagamento) REFERENCES Forma_Pagamento(id_forma_pagamento)
);

CREATE TABLE Avaliacao (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_corrida INT NOT NULL,
    avaliador_tipo ENUM('PASSAGEIRO','MOTORISTA'),
    nota INT,
    comentario VARCHAR(255),
    data_avaliacao DATETIME,

    CONSTRAINT fk_avaliacao_corrida FOREIGN KEY (id_corrida) REFERENCES Corrida(id_corrida)
);


INSERT INTO Usuario
(nome, email, telefone, senha, data_cadastro)
VALUES
('Joao Silva', 'joao@email.com', '11999990001', '123456', '2024-01-10 10:00:00'),
('Maria Souza', 'maria@email.com', '11999990002', '123456', '2024-01-15 14:30:00'),
('Pedro Santos', 'pedro@email.com', '11999990003', '123456', '2024-01-20 09:15:00');

INSERT INTO Motorista
(nome, cpf, cnh, telefone, email, senha, data_cadastro, status)
VALUES
('Carlos Lima', '111.111.111-11', 'CNH12345', '11988880001', 'carlos@email.com', '123456', '2024-01-05 08:00:00', 'ATIVO'),
('Fernanda Costa', '222.222.222-22', 'CNH54321', '11988880002', 'fernanda@email.com', '123456', '2024-01-07 09:00:00', 'ATIVO'),
('Lucas Almeida', '333.333.333-33', 'CNH98765', '11988880003', 'lucas@email.com', '123456', '2024-01-08 10:00:00', 'ATIVO');

INSERT INTO Categoria
(nome, tarifa_base, valor_km, valor_minuto)
VALUES
('Padrao', 5.00, 2.50, 0.50),
('Premium', 10.00, 4.00, 1.00),
('Black', 15.00, 5.50, 1.50);

INSERT INTO Veiculo
(id_motorista, placa, modelo, marca, cor, ano, capacidade_passageiros)
VALUES
(1, 'ABC1D23', 'Onix', 'Chevrolet', 'Prata', 2022, 4),
(2, 'XYZ9K87', 'Corolla', 'Toyota', 'Preto', 2023, 4),
(3, 'DEF4G56', 'HB20', 'Hyundai', 'Branco', 2021, 4);

INSERT INTO Forma_Pagamento
(id_usuario, tipo, descricao, identificador)
VALUES
(1, 'PIX', 'Chave Pix', 'joao@email.com'),
(2, 'CREDITO', 'Cartao Visa', '****1234'),
(3, 'DEBITO', 'Cartao Mastercard', '****5678');

INSERT INTO Corrida
(
id_usuario,
id_motorista,
id_veiculo,
id_categoria,
data_hora_solicitacao,
data_hora_inicio,
data_hora_termino,
endereco_origem,
endereco_destino,
distancia,
valor_total,
status
)
VALUES
(
1,
1,
1,
1,
'2024-06-10 08:00:00',
'2024-06-10 08:05:00',
'2024-06-10 08:30:00',
'Rua A',
'Rua B',
12.50,
38.00,
'FINALIZADA'
),
(
2,
2,
2,
2,
'2024-06-12 09:00:00',
'2024-06-12 09:05:00',
'2024-06-12 09:45:00',
'Rua C',
'Rua D',
18.00,
85.00,
'FINALIZADA'
),
(
3,
3,
3,
3,
'2024-06-15 14:00:00',
'2024-06-15 14:10:00',
'2024-06-15 14:50:00',
'Rua E',
'Rua F',
20.00,
125.00,
'FINALIZADA'
);

INSERT INTO Pagamento
(id_corrida, id_forma_pagamento, valor_pago, data_hora_pagamento, status)
VALUES
(1, 1, 38.00, '2024-06-10 08:31:00', 'PAGO'),
(2, 2, 85.00, '2024-06-12 09:46:00', 'PAGO'),
(3, 3, 125.00, '2024-06-15 14:51:00', 'PAGO');

INSERT INTO Avaliacao
(id_corrida, avaliador_tipo, nota, comentario, data_avaliacao)
VALUES
(1, 'PASSAGEIRO', 5, 'Motorista excelente', '2024-06-10 08:35:00'),
(1, 'MOTORISTA', 5, 'Passageiro educado', '2024-06-10 08:36:00'),
(2, 'PASSAGEIRO', 4, 'Viagem tranquila', '2024-06-12 09:48:00'),
(3, 'PASSAGEIRO', 5, 'Excelente atendimento', '2024-06-15 15:00:00');

SELECT
u.nome AS usuario,
c.id_corrida,
c.data_hora_solicitacao,
c.endereco_origem,
c.endereco_destino,
c.valor_total,
c.status
FROM Corrida c
INNER JOIN Usuario u
ON c.id_usuario = u.id_usuario;

SELECT
m.nome AS motorista,
c.id_corrida,
c.endereco_origem,
c.endereco_destino,
c.valor_total,
c.status
FROM Corrida c
INNER JOIN Motorista m
ON c.id_motorista = m.id_motorista;

SELECT
v.placa,
v.modelo,
v.marca,
m.nome AS motorista
FROM Veiculo v
INNER JOIN Motorista m
ON v.id_motorista = m.id_motorista;

SELECT
u.nome,
f.tipo,
f.descricao,
f.identificador
FROM Forma_Pagamento f
INNER JOIN Usuario u
ON f.id_usuario = u.id_usuario;

SELECT
p.id_pagamento,
c.id_corrida,
u.nome AS usuario,
p.valor_pago,
p.status
FROM Pagamento p
INNER JOIN Corrida c
ON p.id_corrida = c.id_corrida
INNER JOIN Usuario u
ON c.id_usuario = u.id_usuario;

SELECT
a.id_avaliacao,
c.id_corrida,
a.avaliador_tipo,
a.nota,
a.comentario
FROM Avaliacao a
INNER JOIN Corrida c
ON a.id_corrida = c.id_corrida;

SELECT
cat.nome AS categoria,
COUNT(c.id_corrida) AS quantidade_corridas
FROM Corrida c
INNER JOIN Categoria cat
ON c.id_categoria = cat.id_categoria
GROUP BY cat.nome;

SELECT
cat.nome AS categoria,
SUM(c.valor_total) AS faturamento
FROM Corrida c
INNER JOIN Categoria cat
ON c.id_categoria = cat.id_categoria
WHERE c.status = 'FINALIZADA'
GROUP BY cat.nome;

SELECT
c.id_corrida,
u.nome AS usuario,
m.nome AS motorista,
v.modelo,
cat.nome AS categoria,
c.valor_total,
c.status
FROM Corrida c
INNER JOIN Usuario u
ON c.id_usuario = u.id_usuario
INNER JOIN Motorista m
ON c.id_motorista = m.id_motorista
INNER JOIN Veiculo v
ON c.id_veiculo = v.id_veiculo
INNER JOIN Categoria cat
ON c.id_categoria = cat.id_categoria;

SELECT
c.id_corrida,
AVG(a.nota) AS media_avaliacao
FROM Corrida c
INNER JOIN Avaliacao a
ON c.id_corrida = a.id_corrida
GROUP BY c.id_corrida;