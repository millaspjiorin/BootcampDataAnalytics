-- MODULO 2
-- Criar um banco de dados
CREATE DATABASE sucos;

-- Utilizar banco de dados criado
USE sucos;

-- Criar uma tabela
CREATE TABLE tbCliente(
CPF VARCHAR (11) ,
NOME VARCHAR (100) ,
ENDERECO1 VARCHAR (150) ,
ENDERECO2 VARCHAR (150) ,
BAIRRO VARCHAR (50) ,
CIDADE VARCHAR (50) ,
ESTADO VARCHAR (2) ,
CEP VARCHAR (8) ,
IDADE SMALLINT,
SEXO VARCHAR (1) ,
LIMITE_CREDITO FLOAT ,
VOLUME_COMPRA FLOAT ,
PRIMEIRA_COMPRA BIT );

CREATE TABLE tbVendedores(
MATRICULA VARCHAR(5),
NOME VARCHAR(100),
PERCENTUAL_COMISSAO FLOAT);

CREATE TABLE tbProduto(
PRODUTO VARCHAR(20),
NOME VARCHAR(150),
EMBALAGEM VARCHAR(50),
TAMANHO VARCHAR(50),
SABOR VARCHAR(50),
PRECO_LISTA FLOAT);

CREATE TABLE tbProduto2(
PRODUTO VARCHAR(20),
NOME VARCHAR(150),
EMBALAGEM VARCHAR(50),
TAMANHO VARCHAR(50),
SABOR VARCHAR(50),
PRECO_LISTA FLOAT);

-- Excluir uma tabela
DROP TABLE tbProduto2;

-- MODULO 3
USE sucos;

-- Inserir dados na tabela 
INSERT INTO tbProduto(
PRODUTO, NOME, EMBALAGEM, TAMANHO, SABOR, PRECO_LISTA)
VALUES(
'1040107' , 'Light - 350 ml - Melancia' , 'Lata' , '350 ml' , 'Melancia' , 4.56);

-- Visualizar dados da tabela
SELECT * FROM tbProduto;

INSERT INTO tbVendedores(
MATRICULA, NOME, PERCENTUAL_COMISSAO)
VALUES(
'00233', 'João Geraldo da Fonseca', '0.10');

SELECT * FROM tbVendedores;

INSERT INTO tbVendedores(
MATRICULA, NOME, PERCENTUAL_COMISSAO)
VALUES
('00235', 'Márcio Almeida Silva', '0.08'),
('00236', 'Cláudia Morais', '0.08');

SELECT * FROM tbVendedores;

INSERT INTO tbProduto(
PRODUTO, NOME, EMBALAGEM, TAMANHO, SABOR, PRECO_LISTA)
VALUES
('1037797' , 'Clean - 2 Litros - Laranja' , 'PET' , '2 Litros' , 'Laranja' , 16.01),
('1000889' , 'Sabor da Montanha - 700 ml - Uva' , 'Garrafa' , '700 ml' , 'Uva' , 6.31),
('1004327' , 'Videira do Campo - 1,5 Litros - Melancia' , 'PET' , '1,5 Litros' , 'Melancia' , 19.51);

SELECT * FROM tbProduto;

INSERT INTO tbproduto (
PRODUTO,  NOME, EMBALAGEM, TAMANHO, SABOR, PRECO_LISTA) 
VALUES
('544931' , 'Frescor do Verão - 350 ml - Limão' , 'PET' , '350 ml' , 'Limão' , 3.20),
('1078680' , 'Frescor do Verão - 470 ml - Manga', 'Lata' , '470 ml'  ,'Manga' , 5.18);

-- Atualizar informações da tabela
UPDATE tbProduto 
SET EMBALAGEM = 'Lata',
PRECO_LISTA = '2.46'
WHERE PRODUTO = '544931'; 

UPDATE tbProduto 
SET EMBALAGEM = 'Garrafa'
WHERE PRODUTO = '1078680'; 

SELECT * FROM tbProduto;

UPDATE tbvendedores
SET PERCENTUAL_COMISSAO = '0.11'
WHERE MATRICULA = '00236';

UPDATE tbvendedores
SET NOME = 'José Geraldo da Fonseca Junior'
WHERE MATRICULA = '00233';

SELECT * FROM tbvendedores;

-- Excluir informações da tabela
DELETE FROM tbproduto
WHERE PRODUTO = '1078680';

SELECT * FROM tbproduto;

DELETE FROM tbvendedores
WHERE MATRICULA = '00233';

SELECT * FROM tbvendedores;

-- Atribuir primary key em tabela existente
ALTER TABLE tbproduto
ADD PRIMARY KEY (PRODUTO);

-- Tentar inserir produto que PK já existe para visualizar erro
INSERT INTO tbProduto(
PRODUTO, NOME, EMBALAGEM, TAMANHO, SABOR, PRECO_LISTA)
VALUES
('1037797' , 'Clean - 2 Litros - Laranja' , 'PET' , '2 Litros' , 'Laranja' , 16.01);

ALTER TABLE tbcliente
ADD PRIMARY KEY (CPF);

-- Criar coluna nova em tabela já existente
ALTER TABLE tbcliente
ADD COLUMN (NASCIMENTO DATE);

INSERT INTO tbcliente(
CPF, NOME, ENDERECO1, ENDERECO2, BAIRRO, CIDADE, ESTADO, CEP, IDADE, SEXO, LIMITE_CREDITO, VOLUME_COMPRA, PRIMEIRA_COMPRA, NASCIMENTO)
VALUES
('00388934505' , 'João da Silva' , 'Rua Projetada A Número 10' , '' , 'Vila Romana' , 'Caratinga' , 'Amazonas' , '2222222' , 30 , 'M' , 10000.00 , 2000 , 0, '1989-10-05');

SELECT * FROM tbcliente;

-- Exercício para treinar: incluir campos DATA_ADMISSÃO e DE_FERIAS na tabela tbVendedores, recriar chave primária e incluir informações

DROP TABLE tbvendedores;

CREATE TABLE tbVendedor(
MATRICULA VARCHAR(5) PRIMARY KEY,
NOME VARCHAR(100),
PERCENTUAL_COMISSAO FLOAT,
DATA_ADMISSAO DATE,
DE_FERIAS BIT);

INSERT INTO tbVendedor(
MATRICULA, NOME, DATA_ADMISSAO, PERCENTUAL_COMISSAO, DE_FERIAS)
VALUES
('00235' , 'Márcio Almeida Silva' , '2014-08-15' , 0.08 , 0),
('00236' , 'Cláudia Morais' , '2013-09-17' , 0.08 , 1),
('00237' , 'Roberta Martins' , '2017-03-18' , 0.11 , 1),
('00238' , 'Pericles Alves' , '2016-08-21' , 0.11 , 0);

SELECT * FROM tbVendedor;

-- Modulo 4
-- Continuar após executar script que popula as tabelas (dados_tabelas.sql)

-- Limitar SELECT por campo e 5 primeiras linhas
SELECT CPF, NOME, SEXO FROM tbCliente LIMIT 5;

-- Criar alias para os campos
SELECT CPF AS CPF_CLIENTE, NOME AS NOME_CLIENTE FROM tbCliente;

-- Filtrar produtos com embalagem PET
SELECT * FROM tbproduto
WHERE EMBALAGEM = 'PET';

-- Filtrar por clientes com 22 anos
SELECT * FROM tbcliente
WHERE IDADE = 22;

-- Filtrar por clientes com mais de 22 anos
SELECT * FROM tbcliente
WHERE IDADE > 22;

-- Filtrar por clientes com idade diferente de 22 anos
SELECT * FROM tbcliente
WHERE IDADE <> 22;

-- Filtrar por clientes com nome em ordem alfabética após Fernando Cavalcante
SELECT * FROM tbcliente
WHERE NOME > 'Fernando Cavalcante';

-- Filtrar vendedores com comissão maior que 10%
SELECT * FROM tbvendedor
WHERE PERCENTUAL_COMISSAO > 0.10;

-- Filtrar clientes que nasceram no dia 13/01/1995
SELECT * FROM tbcliente
WHERE DATA_NASCIMENTO = '1995-01-13';

-- Filtrar clientes que nasceram depois do dia 13/01/1995
SELECT * FROM tbcliente
WHERE DATA_NASCIMENTO > '1995-01-13';

-- Filtrar clientes que nasceram no ano de 1995
SELECT * FROM tbcliente
WHERE YEAR(DATA_NASCIMENTO) = 1995;

-- Filtrar vendedores admitidos a partir de 2016
SELECT * FROM tbvendedor
WHERE YEAR(DATA_ADMISSAO) >= 2016;

-- Filtrar clientes com idade maior ou igual a 18 e menor ou igual a 22 anos e do sedxo masculino
SELECT * FROM tbcliente
WHERE IDADE >=18 AND IDADE <=22 AND SEXO = 'M';

-- Filtrar vendedores que estão de férias e que foram admitidos antes de 2016
SELECT * FROM TABELA_DE_VENDEDORES 
WHERE YEAR(DATA_ADMISSAO) < 2016 AND DE_FERIAS = 1;