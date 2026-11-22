CREATE INDEX idx_func_ano_admissao 
ON tb_funcionarios(EXTRACT(YEAR FROM data_admissao));