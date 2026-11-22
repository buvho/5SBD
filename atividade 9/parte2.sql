CREATE TABLE tb_chamados_legado (
    id_chamado NUMBER PRIMARY KEY,
    descricao  VARCHAR2(100) NOT NULL
);

CREATE SEQUENCE seq_chamados_legado START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_chamados_bi
BEFORE INSERT ON tb_chamados_legado
FOR EACH ROW
BEGIN
    IF :NEW.id_chamado IS NULL THEN
        :NEW.id_chamado := seq_chamados_legado.NEXTVAL;
    END IF;
END;
/

CREATE SEQUENCE seq_chamados_moderno START WITH 1 INCREMENT BY 1;

CREATE TABLE tb_chamados_moderno (
    id_chamado NUMBER DEFAULT ON NULL seq_chamados_moderno.NEXTVAL PRIMARY KEY,
    descricao  VARCHAR2(100) NOT NULL
);