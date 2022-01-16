CREATE DATABASE sucos_vendas;

USE sucos_vendas;

-- Filtrar produtos que são do sabor manga ou do sabor uva
SELECT * FROM tabela_de_produtos 
WHERE SABOR = 'Manga' OR SABOR = 'Uva';

-- Filtrar produtos que são do sabor manga e do tamanho 700 ml
SELECT * FROM tabela_de_produtos 
WHERE SABOR = 'Manga' AND TAMANHO = '700 ml';

-- Filtrar produtos que não são do sabor manga
SELECT * FROM tabela_de_produtos 
WHERE NOT SABOR = 'Manga';

-- Filtrar produtos que são do sabor manga, mas não são do tamanho 700 ml
SELECT * FROM tabela_de_produtos 
WHERE SABOR = 'Manga' AND NOT (TAMANHO = '700 ml');

-- Filtrar clientes das cidades de São Paulo ou Rio de Janeiro, que possuam idade maior ou igual a 20 e menor ou igual a 22
SELECT * FROM tabela_de_clientes 
WHERE CIDADE IN ('Rio de Janeiro', 'São Paulo')
AND (IDADE >= 20 AND IDADE <= 22);

-- Filtrar clientes que possuem Silva em algum lugar do nome
SELECT * FROM tabela_de_clientes
WHERE NOME LIKE '%Silva%';

-- Filtrar clientes que possuem último sobrenome Mattos
SELECT * FROM tabela_de_clientes
WHERE NOME LIKE '%Mattos';

-- Filtrar somente as combinações distintas para as colunas embalagem e tamanho
SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos;

-- Filtrar somente as embalagens e tamanhos disponíveis para os produtos do sabor uva
SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos
WHERE SABOR = 'Uva';

-- Filtrar bairros da cidade do Rio de Janeiro que possuem clintes
SELECT DISTINCT BAIRRO FROM tabela_de_clientes
WHERE CIDADE = 'Rio de Janeiro';

-- Filtrar 4 primeiras linhas da tabela de clientes
SELECT * FROM tabela_de_clientes
LIMIT 4;

-- Filtrar a partir da posição 2, os três próximos na tabela clientes (lembrando que a primeira linha é 0)
SELECT * FROM tabela_de_clientes
LIMIT 2,3;

-- Filtrar as 10 primeiras vendas do dia 01/01/2017
SELECT * FROM notas_fiscais
WHERE DATA_VENDA = '2017-01-01'
LIMIT 10;

-- Filtrar e ordenar os 10 primeiros clientes em ordem alfabética crescente
SELECT * FROM tabela_de_clientes 
ORDER BY NOME ASC
LIMIT 10;

-- Filtrar e ordenar os 10 primeiros clientes em ordem alfabética decrescente
SELECT * FROM tabela_de_clientes 
ORDER BY NOME DESC
LIMIT 10;

-- Filtrar e ordenar os clientes  e estados em ordem alfabética crescente
-- exibindo apenas as colunas de CPF, NOME, CIDADE E ESTADO
SELECT CPF, NOME, CIDADE, ESTADO FROM tabela_de_clientes 
ORDER BY NOME, ESTADO;

-- Qual (ou quais) foi (foram) a(s) maior(es) venda(s) do produto “Linha Refrescante - 
-- 1 Litro - Morango/Limão”, em quantidade? (Obtenha este resultado usando 2 SQLs).

SELECT * FROM tabela_de_produtos
WHERE NOME_DO_PRODUTO = 'Linha Refrescante - 1 Litro - Morango/Limão';

SELECT * FROM itens_notas_fiscais
WHERE CODIGO_DO_PRODUTO = '1101035' 
ORDER BY QUANTIDADE DESC;