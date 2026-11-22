WITH ranking_produtos AS (
    SELECT 
        cat.nome AS categoria,
        p.nome AS produto,
        SUM(iv.quantidade) AS qtd_total_vendida,
        DENSE_RANK() OVER (
            PARTITION BY cat.id_categoria 
            ORDER BY SUM(iv.quantidade) DESC
        ) AS ranking
    FROM itens_venda iv
    JOIN vendas v ON iv.id_venda = v.id_venda
    JOIN produtos p ON iv.id_produto = p.id_produto
    JOIN categorias cat ON p.id_categoria = cat.id_categoria
    WHERE v.status = 'FECHADA'
    GROUP BY cat.id_categoria, cat.nome, p.id_produto, p.nome
)
SELECT 
    categoria,
    produto,
    qtd_total_vendida,
    ranking
FROM ranking_produtos
WHERE ranking <= 2
ORDER BY categoria ASC, ranking ASC;