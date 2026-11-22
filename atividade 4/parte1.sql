SELECT 
    c.nome AS nome_cliente,
    v.dt_venda,
    v.valor_liquido,
    ROW_NUMBER() OVER (
        PARTITION BY v.id_cliente 
        ORDER BY v.dt_venda ASC, v.id_venda ASC
    ) AS numero_compra
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.status = 'FECHADA'
ORDER BY c.nome, numero_compra;