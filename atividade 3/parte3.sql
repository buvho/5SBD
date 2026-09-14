WITH receita_mensal AS (
    SELECT 
        TRUNC(dt_venda, 'MM') AS mes_venda,
        SUM(valor_liquido) AS faturamento_total
    FROM TB_VENDA
    WHERE status = 'FECHADA'
    GROUP BY TRUNC(dt_venda, 'MM')
)
SELECT 
    mes_venda,
    faturamento_total
FROM receita_mensal
ORDER BY mes_venda;

WITH quantidade_por_produto AS (
    SELECT 
        id_produto,
        SUM(quantidade) AS total_vendido
    FROM TB_VENDA_ITEM
    GROUP BY id_produto
)

SELECT 
    p.nome AS nome_produto,
    qp.total_vendido
FROM quantidade_por_produto qp
INNER JOIN TB_PRODUTO p ON qp.id_produto = p.id_produto
ORDER BY qp.total_vendido DESC
FETCH FIRST 5 ROWS ONLY;