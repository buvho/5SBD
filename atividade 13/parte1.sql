CREATE OR REPLACE FUNCTION fnc_calcular_tempo_casa (
    p_data_admissao IN DATE
) RETURN NUMBER IS
    v_anos NUMBER;
BEGIN
    IF p_data_admissao IS NULL OR p_data_admissao > SYSDATE THEN
        RETURN 0;
    END IF;

    v_anos := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data_admissao) / 12);
    RETURN v_anos;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END fnc_calcular_tempo_casa;
/

SELECT 
    nome,
    departamento,
    TO_CHAR(data_admissao, 'DD/MM/YYYY') AS admissao,
    fnc_calcular_tempo_casa(data_admissao) AS anos_de_casa
FROM tb_colaboradores
ORDER BY anos_de_casa DESC;