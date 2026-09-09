CREATE TABLE TB_CLIENTE (
    id_cliente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    ativo CHAR(1) DEFAULT 'S' CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE TB_VENDEDOR (
    id_vendedor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome varchar(150) NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL,
    ativo CHAR(1) DEFAULT 'S' CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE TB_CATEGORIA(
    id_categoria INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE TB_PRODUTO(
    id_produto INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_categoria REFERENCES TB_CATEGORIA(id_categoria),
    sku VARCHAR(100) UNIQUE NOT NULL,
    nome VARCHAR(300) NOT NULL,
    preco_unit INT CHECK(preco_unit > 0)
);

CREATE TABLE TB_VENDA(
    id_venda INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente INT REFERENCES TB_CLIENTE(id_cliente),
    id_vendedor INT REFERENCES TB_VENDEDOR(id_vendedor),
    dt_venda TIMESTAMP NOT NULL,
    valor_liquido DECIMAL(15,2) NOT NULL,
    canal CHAR(8) CHECK (ativo IN ('APP', 'SITE','LOJA', 'TELEFONE')),
    status CHAR(9) CHECK (ativo IN ('ABERTA', 'FECHADA','CANCELADA'))
);

CREATE TABLE TB_VENDA_ITEM(
    id_venda_item INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_venda INT REFERENCES TB_VENDA(id_venda) ON DELETE CASCADE,
    id_produto INT REFERENCES TB_PRODUTO(id_produto),
    quantidade NUMBER NOT NULL CHECK (quantidade > 0),
    valor_unit NUMBER NOT NULL,
    percentual_desconto NUMBER DEFAULT 0  NOT NULL CHECK (percentual_desconto <= 50 and percentual_desconto >= 0),
    valor_total NUMBER GENERATED ALWAYS AS ((valor_unit * quantidade) * ((percentual_desconto / 100) - 1)) VIRTUAL
);