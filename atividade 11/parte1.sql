SELECT 
    s.synonym_name,
    s.table_owner AS schema_destino,
    s.table_name  AS objeto_destino,
    NVL(o.status, 'INEXISTENTE (ÓRFÃO)') AS status_objeto_alvo
FROM user_synonyms s
LEFT JOIN all_objects o
       ON s.table_owner = o.owner
      AND s.table_name  = o.object_name
      AND o.object_type IN ('TABLE', 'VIEW', 'SEQUENCE', 'PROCEDURE', 'FUNCTION', 'PACKAGE', 'MATERIALIZED VIEW', 'TYPE', 'SYNONYM')
WHERE s.db_link IS NULL
  AND (o.object_name IS NULL OR o.status = 'INVALID')
ORDER BY s.synonym_name;