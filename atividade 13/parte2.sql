CREATE OR REPLACE FUNCTION fnc_teste_dml RETURN NUMBER IS
BEGIN
    UPDATE tb_colaboradores
       SET departamento = departamento
     WHERE ROWNUM = 1;

    RETURN 1;
END fnc_teste_dml;

SELECT fnc_teste_dml() FROM DUAL;