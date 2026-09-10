CREATE TABLE TB_CLIENTE (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    telefone VARCHAR(20),
    dt_cadastro DATE,
    ativo CHAR(1) DEFAULT 'S' CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE TB_VENDEDOR (
    id_vendedor INT PRIMARY KEY,
    nome varchar(150) NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL,
    dt_admissao DATE,
    ativo CHAR(1) DEFAULT 'S' CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE TB_CATEGORIA(
    id_categoria INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE TB_PRODUTO(
    id_produto INT PRIMARY KEY,
    id_categoria REFERENCES TB_CATEGORIA(id_categoria),
    sku VARCHAR(100) UNIQUE NOT NULL,
    nome VARCHAR(300) NOT NULL,
    preco_unit INT CHECK(preco_unit > 0),
    ativo CHAR(1) DEFAULT 'S' CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE TB_VENDA(
    id_venda INT PRIMARY KEY,
    id_cliente INT REFERENCES TB_CLIENTE(id_cliente),
    id_vendedor INT REFERENCES TB_VENDEDOR(id_vendedor),
    dt_venda DATE NOT NULL,
    valor_bruto DECIMAL(15,2) NOT NULL,
    desconto_total DECIMAL(15,2) NOT NULL,
    valor_liquido DECIMAL(15,2) NOT NULL,
    canal CHAR(8) CHECK (canal IN ('APP', 'SITE','LOJA', 'TELEFONE')),
    status CHAR(9) CHECK (status IN ('ABERTA', 'FECHADA','CANCELADA'))
);

CREATE TABLE TB_VENDA_ITEM(
    id_item INT PRIMARY KEY,
    id_venda INT REFERENCES TB_VENDA(id_venda) ON DELETE CASCADE,
    id_produto INT REFERENCES TB_PRODUTO(id_produto),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unit NUMBER NOT NULL,
    desconto_item NUMBER DEFAULT 0,
    valor_total NUMBER
);

CREATE TABLE TB_CALENDARIO (
    dt_ref DATE PRIMARY KEY,
    ano INT NOT NULL,
    mes INT NOT NULL,
    dia INT NOT NULL,
    trimestre INT NOT NULL,
    nome_mes VARCHAR(20) NOT NULL,
    dia_semana INT NOT NULL,
    nome_dia_semana VARCHAR(20) NOT NULL
);
