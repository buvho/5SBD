SELECT 
    v.nome AS nome_vendedor,
    SUM(ve.valor_liquido) AS total_vendido
FROM TB_VENDEDOR v
INNER JOIN TB_VENDA ve ON v.id_vendedor = ve.id_vendedor
WHERE ve.status = 'FECHADA'
GROUP BY v.id_vendedor, v.nome
ORDER BY total_vendido DESC;

SELECT 
    c.nome AS nome_cliente,
    ve.dt_venda,
    ve.valor_liquido,
    ve.status
FROM TB_CLIENTE c
INNER JOIN TB_VENDA ve ON c.id_cliente = ve.id_cliente
ORDER BY ve.dt_venda DESC;

SELECT 
    c.nome AS nome_cliente,
    SUM(ve.valor_liquido) AS total_comprado
FROM TB_CLIENTE c
INNER JOIN TB_VENDA ve ON c.id_cliente = ve.id_cliente
WHERE ve.status = 'FECHADA'
GROUP BY c.id_cliente, c.nome
ORDER BY total_comprado DESC
FETCH FIRST 1 ROWS ONLY;