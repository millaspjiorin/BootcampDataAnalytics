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

-- Unir tabelas vendedores e notas fiscais utilizando a matrícula como campo em comum
SELECT * FROM tabela_de_vendedores A
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA;

-- Contar a quantidade de notas fiscais emitidas por vendedor
SELECT A.MATRICULA, A.NOME, COUNT(*) AS NOTAS_FISCAIS_EMITIDAS FROM tabela_de_vendedores A
INNER  JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;

-- Obtenha o faturamento anual da empresa. Leve em consideração que o valor financeiro das vendas consiste em multiplicar a quantidade pelo preço.
SELECT YEAR(DATA_VENDA) as ANO, SUM(QUANTIDADE * PRECO) AS FATURAMENTO
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF 
ON NF.NUMERO = INF.NUMERO
GROUP BY YEAR(DATA_VENDA);

-- Filtrar clientes que nunca fizeram nenhuma compra
SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
ON A.CPF = B.CPF
WHERE B.CPF IS NULL;

-- Unir duas tabelas exibindo inclusive registros repetidos
SELECT DISTINCT BAIRRO, NOME, 'CLIENTE' AS TIPO FROM tabela_de_clientes
UNION
SELECT DISTINCT BAIRRO, NOME, 'VENDEDOR' AS TIPO FROM tabela_de_vendedores;

-- Sub consulta: consultar clientes em que há escritórios no mesmo bairro
SELECT * FROM tabela_de_clientes
WHERE BAIRRO IN (SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);

-- Sub consulta: Quais são as embalagens cujo o maior preço é maior ou igual a R$10,00?
SELECT X.EMBALAGEM, X.PRECO_MAXIMO FROM 
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO FROM tabela_de_produtos
GROUP BY EMBALAGEM) X
WHERE X.PRECO_MAXIMO >= 10;	

-- Retornar nome e cpf do cliente no mesmo campo utilizando função
SELECT CONCAT(NOME, ' (' , CPF, ') ' ) AS RESULTADO FROM tabela_de_clientes;

-- Faça uma consulta listando o nome do cliente e o endereço completo 
-- (Com rua, bairro, cidade e estado).
SELECT NOME, CONCAT(ENDERECO_1,', ',BAIRRO,', ',CIDADE,' - ',ESTADO) AS 'ENDEREÇO COMPLETO' FROM tabela_de_clientes;

-- Retornar o dia, mês e ano da data da venda utilizando função 
SELECT DISTINCT DATA_VENDA, DAYNAME(DATA_VENDA) AS DIA, 
MONTHNAME(DATA_VENDA) AS MÊS, YEAR(DATA_VENDA) AS ANO FROM notas_fiscais;

-- Crie uma consulta que mostre o nome e a idade atual dos clientes.
SELECT NOME, TIMESTAMPDIFF(YEAR,DATA_DE_NASCIMENTO,CURDATE()) AS 'IDADE' FROM tabela_de_clientes;

-- Na tabela de notas fiscais temos o valor do imposto. Já na tabela de itens temos a 
-- quantidade e o faturamento. Calcule o valor do imposto pago no ano de 2016 
-- arredondando para o menor inteiro.
SELECT YEAR(DATA_VENDA) AS ANO, FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) AS IMPOSTO
FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY YEAR(DATA_VENDA);

-- * Queremos construir um SQL cujo resultado seja, para cada cliente:
-- “O cliente João da Silva faturou 120000 no ano de 2016”.
-- Somente para o ano de 2016. 
SELECT CONCAT('O cliente ', TC.NOME, ' faturou ', 
CAST(SUM(INF.QUANTIDADE * INF.preco) AS char (20))
 , ' no ano ', CAST(YEAR(NF.DATA_VENDA) AS char (20))) AS SENTENCA FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
INNER JOIN tabela_de_clientes TC ON NF.CPF = TC.CPF
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY TC.NOME, YEAR(DATA_VENDA);

-- RELATÓRIOS

-- Consulta com vendas de clientes por mês
SELECT NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS FROM itens_notas_fiscais INF
INNER JOIN notas_fiscais NF
ON INF.NUMERO = NF.NUMERO
GROUP BY NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');

-- Limite de compra por cliente
SELECT TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA AS QUANTIDADE_LIMITE FROM tabela_de_clientes TC;

-- Relatório de vendas válidas
SELECT X.CPF, X.NOME, X.MES_ANO, X.QUANTIDADE_VENDAS, X.QUANTIDADE_LIMITE,
CASE WHEN (X.QUANTIDADE_LIMITE - X.QUANTIDADE_VENDAS) < 0 THEN 'INVÁLIDA'
ELSE 'VÁLIDA' END AS STATUS_VENDA
FROM (
SELECT NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO
, SUM(INF.QUANTIDADE) AS QUANTIDADE_VENDAS 
, MAX(TC.VOLUME_DE_COMPRA) AS QUANTIDADE_LIMITE FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
INNER JOIN TABELA_DE_CLIENTES TC 
ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')) X;
