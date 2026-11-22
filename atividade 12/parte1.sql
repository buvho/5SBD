
CREATE OR REPLACE PROCEDURE prc_reajustar_saldo_em_massa (
    p_percentual       IN  NUMBER,
    p_total_atualizado OUT NUMBER
) IS
BEGIN
    IF p_percentual IS NULL OR p_percentual <= 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'O percentual de reajuste deve ser maior que zero.');
    END IF;

    UPDATE tb_contas
       SET saldo = ROUND(saldo * (1 + (p_percentual / 100)), 2)
     WHERE status = 'ATIVA';

    p_total_atualizado := SQL%ROWCOUNT;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        p_total_atualizado := 0;
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20011, 'Erro ao aplicar reajuste em massa: ' || SQLERRM);
END prc_reajustar_saldo_em_massa;
/

DECLARE
    v_qtd_afetada NUMBER;
BEGIN
    prc_reajustar_saldo_em_massa(
        p_percentual       => 5, -- Reajuste de 5%
        p_total_atualizado => v_qtd_afetada
    );

    DBMS_OUTPUT.PUT_LINE('Total de contas ativas reajustadas: ' || v_qtd_afetada);
END;
/