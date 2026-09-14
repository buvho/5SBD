SELECT 
    id_venda, 
    dt_venda, 
    valor_liquido
FROM TB_VENDA
WHERE valor_liquido > (
    SELECT AVG(valor_liquido) 
    FROM TB_VENDA 
    WHERE status = 'FECHADA'
)

SELECT 
    p.nome AS nome_produto
FROM TB_PRODUTO p
WHERE p.ativo = 'S'
AND NOT EXISTS (
    SELECT 1 
    FROM TB_VENDA_ITEM vi 
    WHERE vi.id_produto = p.id_produto
);

SELECT 
    c.nome AS nome_cliente,
    SUM(ve.valor_liquido) AS faturamento_total,
    CASE 
        WHEN SUM(ve.valor_liquido) > 10000.00 THEN 'Ouro'
        WHEN SUM(ve.valor_liquido) >= 2000.00 AND SUM(ve.valor_liquido) <= 10000.00 THEN 'Prata'
        ELSE 'Bronze'
    END AS categoria_cliente
FROM TB_CLIENTE c
INNER JOIN TB_VENDA ve ON c.id_cliente = ve.id_cliente
WHERE ve.status = 'FECHADA'
GROUP BY c.id_cliente, c.nome
ORDER BY faturamento_total DESC;