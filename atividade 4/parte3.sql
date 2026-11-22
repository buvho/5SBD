SELECT 
    vend.nome AS nome_vendedor,
    SUM(v.valor_liquido) AS faturamento_vendedor,
    ROUND(
        (SUM(v.valor_liquido) / SUM(SUM(v.valor_liquido)) OVER ()) * 100, 
        2
    ) AS percentual_participacao
FROM vendas v
JOIN vendedores vend ON v.id_vendedor = vend.id_vendedor
WHERE v.status = 'FECHADA'
GROUP BY vend.id_vendedor, vend.nome
ORDER BY faturamento_vendedor DESC;