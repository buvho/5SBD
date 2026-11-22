CREATE OR REPLACE VIEW v_vendas_por_categoria AS
SELECT 
    TO_CHAR(v.dt_venda, 'YYYY-MM') AS mes_ano,
    cat.nome AS categoria,
    SUM((vi.quantidade * vi.preco_unitario) - NVL(vi.desconto_item, 0)) AS faturamento_acumulado
FROM tb_venda v
JOIN tb_venda_item vi ON v.id_venda = vi.id_venda
JOIN tb_produto p ON vi.id_produto = p.id_produto
JOIN tb_categoria cat ON p.id_categoria = cat.id_categoria
WHERE v.status = 'FECHADA'
GROUP BY TO_CHAR(v.dt_venda, 'YYYY-MM'), cat.id_categoria, cat.nome;