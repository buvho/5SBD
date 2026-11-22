SELECT 
    i.index_name,
    i.index_type,
    i.status,
    e.column_expression
FROM user_indexes i
JOIN user_ind_expressions e 
  ON i.index_name = e.index_name 
 AND i.table_name = e.table_name
WHERE i.table_name = 'TB_FUNCIONARIOS'
  AND i.index_name = 'IDX_FUNC_ANO_ADMISSAO';