CREATE OR REPLACE TYPE t_retangulo AS OBJECT (
    largura NUMBER,
    altura  NUMBER,
    MEMBER FUNCTION calcular_area RETURN NUMBER,
    MEMBER FUNCTION calcular_perimetro RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY t_retangulo AS
    MEMBER FUNCTION calcular_area RETURN NUMBER IS
    BEGIN
        RETURN SELF.largura * SELF.altura;
    END calcular_area;

    MEMBER FUNCTION calcular_perimetro RETURN NUMBER IS
    BEGIN
        RETURN 2 * (SELF.largura + SELF.altura);
    END calcular_perimetro;
END;
/

SELECT 
    r.ret.largura AS largura,
    r.ret.altura AS altura,
    r.ret.calcular_area() AS area,
    r.ret.calcular_perimetro() AS perimetro
FROM (
    SELECT t_retangulo(10, 5) AS ret FROM DUAL
) r;

DECLARE
    v_ret t_retangulo;
BEGIN
    v_ret := t_retangulo(8, 4);
    DBMS_OUTPUT.PUT_LINE('Área: ' || v_ret.calcular_area());
    DBMS_OUTPUT.PUT_LINE('Perímetro: ' || v_ret.calcular_perimetro());
END;
/