CREATE OR REPLACE VIEW v_vendas_resumo AS
SELECT 
    v.id_venda,
    v.dt_venda,
    v.status,
    v.canal,
    c.nome AS nome_cliente,
    vend.nome AS nome_vendedor,
    v.valor_liquido
FROM tb_venda v
JOIN tb_cliente c ON v.id_cliente = c.id_cliente
JOIN tb_vendedor vend ON v.id_vendedor = vend.id_vendedor;