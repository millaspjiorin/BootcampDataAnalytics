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

-- Somar o total do limite de crédito agrupando por estado
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL FROM tabela_de_clientes 
GROUP BY ESTADO;

-- Filtrar o produto mais caro de cada tipo de embalagem
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_produtos
GROUP BY EMBALAGEM;

-- Contar quantos produtos eu tenho de cada tipo de embalagem
SELECT EMBALAGEM, COUNT(*) AS CONTADOR FROM tabela_de_produtos
GROUP BY EMBALAGEM;

-- Somar o limite de crédito agrupando por bairros da cidade do Rio de Janeiro em ordem alfabética
SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes
WHERE CIDADE = 'Rio de Janeiro'
GROUP BY BAIRRO
ORDER BY BAIRRO ASC;

-- Quantos itens de venda existem com a maior quantidade do produto '1101035'?
SELECT MAX(QUANTIDADE) as MAIOR_QUANTIDADE FROM itens_notas_fiscais 
WHERE `CODIGO_DO_PRODUTO` = '1101035';

SELECT COUNT(*) FROM itens_notas_fiscais WHERE codigo_do_produto = '1101035' AND QUANTIDADE = 99;

-- Filtrar estados cuja a soma do limite de crédito é maior que 900000
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM tabela_de_clientes
GROUP BY ESTADO
HAVING SUM(LIMITE_DE_CREDITO) > 900000;

-- Filtrar por tipo de embalagem o maior e o menor preço, mas somente os produtos cujo a soma do preço de lista seja menor ou igual a 80 e o preço máximo maior ou igual a 5
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO, MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
GROUP BY EMBALAGEM
HAVING SUM(PRECO_DE_LISTA) <= 80 AND MAX(PRECO_DE_LISTA) >= 5;

-- Quais foram os clientes que fizeram mais de 2000 compras em 2016?
SELECT CPF, COUNT(*) AS QUANTIDADE_COMPRAS FROM notas_fiscais
WHERE YEAR(DATA_VENDA) = '2016'
GROUP BY CPF
HAVING COUNT(*) > 2000;

-- Utilizar CASE para classificar produtos como barato, em conta ou caro
SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
CASE
	WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
	WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	ELSE 'PRODUTO BARATO'
END AS STATUS_PRECO
FROM tabela_de_produtos;

-- Veja o ano de nascimento dos clientes e classifique-os como: Nascidos antes de 1990 são velhos, 
-- nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças. Liste o nome do cliente e esta classificação.

SELECT NOME, DATA_DE_NASCIMENTO,
CASE
	WHEN YEAR(DATA_DE_NASCIMENTO) < 1990 THEN 'VELHO'
    WHEN YEAR(DATA_DE_NASCIMENTO) >= 1990 AND YEAR(DATA_DE_NASCIMENTO) <= 1995 THEN 'JOVEM'
    ELSE 'CRIANÇA'
END AS CLASSIFICAR_IDADE
FROM tabela_de_clientes;
