-- 1
ALTER MATERIALIZED VIEW mv_vendas_por_produto
REFRESH FAST ON COMMIT;

-- 2
INSERT INTO tb_vendas (id_produto, quantidade, data_venda, valor_total)
VALUES (2, 2, SYSDATE, 2400.00);

COMMIT;

-- 3
SELECT * FROM mv_vendas_por_produto WHERE id_produto = 2;