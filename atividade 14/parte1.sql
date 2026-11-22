CREATE OR REPLACE PACKAGE pkg_gestao_vendas AS
    c_taxa_desconto_padrao CONSTANT NUMBER := 0.05;

    e_estoque_insuficiente EXCEPTION;


    PROCEDURE realizar_venda(
        p_id_produto  IN  NUMBER,
        p_quantidade  IN  NUMBER,
        p_valor_final OUT NUMBER
    );


    PROCEDURE realizar_venda(
        p_id_produto   IN  NUMBER,
        p_quantidade   IN  NUMBER,
        p_desconto_pct IN  NUMBER,
        p_valor_final  OUT NUMBER
    );


    PROCEDURE repor_estoque(
        p_id_produto IN NUMBER,
        p_quantidade IN NUMBER
    );

    FUNCTION verificar_disponibilidade(
        p_id_produto IN NUMBER,
        p_quantidade IN NUMBER
    ) RETURN BOOLEAN;

    FUNCTION faturamento_diario RETURN NUMBER;

    FUNCTION obter_total_vendas_sessao RETURN NUMBER;
END pkg_gestao_vendas;
