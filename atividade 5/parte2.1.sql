ALTER TABLE tb_venda_item
ADD CONSTRAINT ck_venda_item_desconto
CHECK (desconto_item <= (preco_unitario * 0.50));