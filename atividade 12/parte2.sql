CREATE OR REPLACE PROCEDURE prc_sanitizar_texto (
    p_texto IN OUT VARCHAR2
) IS
BEGIN
    IF p_texto IS NOT NULL THEN
        p_texto := UPPER(TRIM(p_texto));
    END IF;
END prc_sanitizar_texto;
/

DECLARE
    v_entrada VARCHAR2(100) := '   alexandre louzada - oracle apex   ';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Antes:  [' || v_entrada || ']');
    
    prc_sanitizar_texto(p_texto => v_entrada);
    
    DBMS_OUTPUT.PUT_LINE('Depois: [' || v_entrada || ']');
END;
/