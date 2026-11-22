\SELECT 
    mview_name,
    refresh_mode,
    refresh_method,
    build_mode,
    fast_refreshable,
    staleness,
    TO_CHAR(last_refresh_date, 'DD/MM/YYYY HH24:MI:SS') AS ultima_atualizacao
FROM user_mviews;

SELECT 
    master AS tabela_base,
    log_table AS nome_tabela_log,
    rowids,
    sequence
FROM user_mview_logs;