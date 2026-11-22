CREATE OR REPLACE VIEW v_cliente_publico AS
SELECT 
    id_cliente,
    nome,
    email,
    cidade,
    estado,
    dt_cadastro
FROM tb_cliente
WHERE ativo = 'S'
WITH READ ONLY;