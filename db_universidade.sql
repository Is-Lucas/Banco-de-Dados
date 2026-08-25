DROP DATABASE IF EXISTS db_universidade;

CREATE DATABASE db_universidade;

USE db_universidade;

CREATE TABLE departamento (
    cod_departamento INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE disciplina (
    cod_disciplina INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    ementa TEXT,
    creditos INT NOT NULL,
    cod_departamento INT NOT NULL,
    cod_orientador INT NOT NULL,
    CONSTRAINT fk_disciplina_departamento FOREIGN KEY (cod_departamento) REFERENCES departamento(cod_departamento),
    CONSTRAINT fk_disciplina_orientador FOREIGN KEY (cod_orientador) REFERENCES orientador(num_orientador)
);

CREATE TABLE orientador (
    num_orientador INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cod_departamento INT NOT NULL,
   CONSTRAINT fk_orientador_departamento FOREIGN KEY (cod_departamento) REFERENCES departamento(cod_departamento)
);

CREATE TABLE aluno (
    cod_aluno INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);

CREATE TABLE aluno_graduacao (
    cod_aluno INT PRIMARY KEY,
    ano_ingresso INT NOT NULL,
    CONSTRAINT fk_aluno_graduacao FOREIGN KEY (cod_aluno) REFERENCES aluno(cod_aluno)
);

CREATE TABLE aluno_pos_graduacao (
    cod_aluno INT PRIMARY KEY,
    formacao_escolar TEXT,
    num_orientador INT,
    CONSTRAINT fk_aluno_pos_graduacao FOREIGN KEY (cod_aluno) REFERENCES aluno(cod_aluno),
    CONSTRAINT fk_pos_orientador FOREIGN KEY (num_orientador) REFERENCES orientador(num_orientador)
);

CREATE TABLE pre_requisito (
    cod_disciplina INT,
    cod_pre_requisito INT,
    PRIMARY KEY (cod_disciplina, cod_pre_requisito),
    FOREIGN KEY (cod_disciplina) REFERENCES disciplina(cod_disciplina),
    FOREIGN KEY (cod_pre_requisito) REFERENCES disciplina(cod_disciplina)
);

CREATE TABLE matricula (
    cod_aluno INT,
    cod_disciplina INT,
    media_final DECIMAL(5,2),
    frequencia DECIMAL(5,2),
    PRIMARY KEY (cod_aluno, cod_disciplina),
    FOREIGN KEY (cod_aluno) REFERENCES aluno(cod_aluno),
    FOREIGN KEY (cod_disciplina) REFERENCES disciplina(cod_disciplina)
);


INSERT INTO departamento (cod_departamento, nome, descricao) VALUES
(1, 'Computação', 'Departamento de Ciência da Computação'),
(2, 'Matemática', 'Departamento de Matemática'),
(3, 'Engenharia', 'Departamento de Engenharia');

INSERT INTO orientador (num_orientador, nome, cod_departamento) VALUES
(101, 'Carlos Silva', 1),
(102, 'Ana Souza', 3),
(201, 'Marcos Lima', 2);

INSERT INTO disciplina (cod_disciplina, nome, ementa, creditos, cod_departamento) VALUES
(1001, 'Programação', 'Lógica e algoritmos', 4, 1),
(1002, 'Banco de Dados', 'Modelagem de dados e SQL', 4, 1),
(1003, 'Estruturas de Dados', 'Listas, filas e árvores', 4, 1),
(2001, 'Cálculo I', 'Limites e derivadas', 6, 2),
(3001, 'Física Geral', 'Mecânica clássica', 4, 3);

INSERT INTO pre_requisito (cod_disciplina, cod_pre_requisito) VALUES
(1002, 1001),
(1003, 1002);

INSERT INTO aluno (cod_aluno, nome, endereco, telefone) VALUES
(1, 'João Souza', 'Rua A, 100', '11999991111'),
(2, 'Maria Oliveira', 'Rua B, 200', '11999992222'),
(3, 'Pedro Santos', 'Rua C, 300', '11999993333'),
(4, 'Juliana Costa', 'Rua D, 400', '11999994444');

INSERT INTO aluno_graduacao (cod_aluno, ano_ingresso) VALUES
(1, 2024),
(2, 2023);

INSERT INTO aluno_pos_graduacao (cod_aluno, formacao_escolar, num_orientador) VALUES
(3, 'Bacharelado em Ciência da Computação', 101),
(4, 'Engenharia de Software', 102);

INSERT INTO matricula (cod_aluno, cod_disciplina, media_final, frequencia) VALUES
(1, 1001, 8.5, 92.0),
(1, 2001, 7.8, 88.0),
(2, 1001, 9.0, 95.0),
(2, 3001, 8.2, 90.0),
(3, 1002, 9.5, 97.0),
(4, 1003, 8.9, 93.0);