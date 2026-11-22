CREATE MATERIALIZED VIEW mv_vendas_categoria
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE
AS
SELECT 
    p.categoria,
    COUNT(v.id_venda) AS total_vendas,
    SUM(v.quantidade) AS qtd_itens_vendidos,
    SUM(v.valor_total) AS faturamento_total
FROM tb_vendas v
JOIN tb_produtos p ON v.id_produto = p.id_produto
GROUP BY p.categoria;