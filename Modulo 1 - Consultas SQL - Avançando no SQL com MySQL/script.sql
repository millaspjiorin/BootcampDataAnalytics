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