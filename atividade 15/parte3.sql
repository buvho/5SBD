CREATE OR REPLACE TRIGGER trg_empregados_auditoria_update
AFTER UPDATE OF salario ON tb_empregados
FOR EACH ROW
WHEN (NEW.salario <> OLD.salario)
BEGIN
    INSERT INTO tb_auditoria_salarios (
        id_empregado,
        operacao,
        salario_anterior,
        salario_novo
    ) VALUES (
        :OLD.id_empregado,
        'UPDATE',
        :OLD.salario,
        :NEW.salario
    );
END trg_empregados_auditoria_update;
/