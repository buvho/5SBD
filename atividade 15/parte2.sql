CREATE OR REPLACE TRIGGER trg_mutating_teste
AFTER INSERT OR UPDATE ON tb_empregados
FOR EACH ROW
DECLARE
    v_total_cargo NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total_cargo
      FROM tb_empregados
     WHERE cargo = :NEW.cargo;

    DBMS_OUTPUT.PUT_LINE('Total no cargo: ' || v_total_cargo);
END trg_mutating_teste;
/

UPDATE tb_empregados
   SET salario = salario + 100
WHERE id_empregado = 1;

DROP TRIGGER trg_mutating_teste;