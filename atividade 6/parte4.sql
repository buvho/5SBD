SELECT 
    mes_ano,
    categoria,
    faturamento_acumulado
FROM v_vendas_por_categoria
WHERE mes_ano = TO_CHAR(SYSDATE, 'YYYY-MM')
  AND faturamento_acumulado > 5000
ORDER BY faturamento_acumulado DESC;