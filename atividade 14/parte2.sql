CREATE OR REPLACE PACKAGE BODY pkg_gestao_vendas AS
    -- Variável privada de sessão para contabilizar operações realizadas
    g_total_vendas_sessao NUMBER := 0;

    -- Subprograma PRIVADO
    PROCEDURE registrar_baixa_estoque(
        p_id_produto IN NUMBER,
        p_quantidade IN NUMBER
    ) IS
    BEGIN
        UPDATE tb_prod_estoque
           SET qtd_estoque = qtd_estoque - p_quantidade
         WHERE id_produto = p_id_produto;
    END registrar_baixa_estoque;

    -- Implementação de verificar_disponibilidade
    FUNCTION verificar_disponibilidade(
        p_id_produto IN NUMBER,
        p_quantidade IN NUMBER
    ) RETURN BOOLEAN IS
        v_estoque_atual NUMBER := 0;
    BEGIN
        SELECT qtd_estoque INTO v_estoque_atual
          FROM tb_prod_estoque
         WHERE id_produto = p_id_produto;

        RETURN (v_estoque_atual >= p_quantidade);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END verificar_disponibilidade;

    -- Implementação da Procedure sobrecarregada (Versão 1)
    PROCEDURE realizar_venda(
        p_id_produto  IN  NUMBER,
        p_quantidade  IN  NUMBER,
        p_valor_final OUT NUMBER
    ) IS
    BEGIN
        realizar_venda(p_id_produto, p_quantidade, 0, p_valor_final);
    END realizar_venda;

    -- Implementação da Procedure sobrecarregada (Versão 2)
    PROCEDURE realizar_venda(
        p_id_produto   IN  NUMBER,
        p_quantidade   IN  NUMBER,
        p_desconto_pct IN  NUMBER,
        p_valor_final  OUT NUMBER
    ) IS
        v_preco_unitario NUMBER(10,2);
        v_total_bruto    NUMBER(12,2);
    BEGIN
        IF NOT verificar_disponibilidade(p_id_produto, p_quantidade) THEN
            RAISE e_estoque_insuficiente;
        END IF;

        SELECT preco INTO v_preco_unitario
          FROM tb_prod_estoque
         WHERE id_produto = p_id_produto;

        v_total_bruto := v_preco_unitario * p_quantidade;
        p_valor_final := v_total_bruto - (v_total_bruto * NVL(p_desconto_pct, 0));

        registrar_baixa_estoque(p_id_produto, p_quantidade);

        INSERT INTO tb_registro_vendas (id_produto, qtd_vendida, valor_venda)
        VALUES (p_id_produto, p_quantidade, p_valor_final);

        g_total_vendas_sessao := g_total_vendas_sessao + 1;

        COMMIT;
    EXCEPTION
        WHEN e_estoque_insuficiente THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20010, 'Estoque insuficiente para atender à quantidade solicitada.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20099, 'Erro ao processar venda no pacote: ' || SQLERRM);
    END realizar_venda;

    -- Implementação de repor_estoque
    PROCEDURE repor_estoque(
        p_id_produto IN NUMBER,
        p_quantidade IN NUMBER
    ) IS
    BEGIN
        IF p_quantidade IS NULL OR p_quantidade <= 0 THEN
            RAISE_APPLICATION_ERROR(-20020, 'A quantidade para reposição deve ser maior que zero.');
        END IF;

        UPDATE tb_prod_estoque
           SET qtd_estoque = qtd_estoque + p_quantidade
         WHERE id_produto = p_id_produto;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20021, 'Produto não encontrado para reposição de estoque.');
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END repor_estoque;

    -- Implementação de faturamento_diario
    FUNCTION faturamento_diario RETURN NUMBER IS
        v_faturamento NUMBER(12,2) := 0;
    BEGIN
        SELECT NVL(SUM(valor_venda), 0) INTO v_faturamento
          FROM tb_registro_vendas
         WHERE TRUNC(data_venda) = TRUNC(SYSDATE);

        RETURN v_faturamento;
    END faturamento_diario;

    -- Implementação de obter_total_vendas_sessao
    FUNCTION obter_total_vendas_sessao RETURN NUMBER IS
    BEGIN
        RETURN g_total_vendas_sessao;
    END obter_total_vendas_sessao;

BEGIN
    g_total_vendas_sessao := 0;
END pkg_gestao_vendas;
/