SELECT nome, salario_base
FROM tb_colaboradores
WHERE fnc_calcular_irrf(salario_base) > 300.00;

CREATE INDEX idx_colab_irrf 
ON tb_colaboradores(fnc_calcular_irrf(salario_base));

SELECT /*+ INDEX(c idx_colab_irrf) */ nome, salario_base
FROM tb_colaboradores c
WHERE fnc_calcular_irrf(salario_base) > 300.00;