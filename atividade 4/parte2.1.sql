WITH vendas_mensais AS (
    SELECT 
        TO_CHAR(v.dt_venda, 'YYYY-MM') AS mes_ano,
        vend.nome AS nome_vendedor,
        SUM(v.valor_liquido) AS total_vendido
    FROM vendas v
    JOIN vendedores vend ON v.id_vendedor = vend.id_vendedor
    WHERE v.status = 'FECHADA'
    GROUP BY TO_CHAR(v.dt_venda, 'YYYY-MM'), vend.id_vendedor, vend.nome
)
SELECT 
    mes_ano,
    nome_vendedor,
    total_vendido,
    DENSE_RANK() OVER (
        PARTITION BY mes_ano 
        ORDER BY total_vendido DESC
    ) AS posicao_ranking
FROM vendas_mensais
ORDER BY mes_ano DESC, posicao_ranking ASC;