--excluindo tabelas do sistema, caso já estejam criadas
DROP TABLE itens_pedido CASCADE CONSTRAINTS;
DROP TABLE pedido CASCADE CONSTRAINTS;
DROP TABLE compra CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE produto CASCADE CONSTRAINTS;
DROP TABLE categoria CASCADE CONSTRAINTS;
DROP TABLE interesses CASCADE CONSTRAINTS;
DROP TABLE fornecedor CASCADE CONSTRAINTS;
DROP TABLE nota_fiscal CASCADE CONSTRAINTS;

--criando tabela itens_pedido
CREATE TABLE itens_pedido(
itens_id NUMBER(5) PRIMARY KEY NOT NULL,
quantidade_prod NUMBER(5) NOT NULL,
preco NUMBER(6,2) NOT NULL
);

--criando tabela pedido
CREATE TABLE pedido(
id_pedido NUMBER(5) PRIMARY KEY NOT NULL,
dt_pedido DATE NOT NULL,
status_pedido VARCHAR2(50),
preco_total NUMBER(6,2) NOT NULL
);

--criando tabela compra
CREATE TABLE compra(
id_compra NUMBER(5) PRIMARY KEY NOT NULL,
data_compra DATE NOT NULL,
metodo_pagamento VARCHAR2(40)
);

--criando tabela nota_fiscal
CREATE TABLE nota_fiscal(
id_nota_fiscal NUMBER(5) PRIMARY KEY NOT NULL,
dt_emissao DATE NOT NULL,
valor_total NUMBER(6,2) NOT NULL
);

--criando tabela cliente
CREATE TABLE cliente(
id_clie NUMBER(5) PRIMARY KEY NOT NULL,
nm_clie VARCHAR2(40) NOT NULL,
email_clie VARCHAR2(40) UNIQUE NOT NULL,
endereco_clie VARCHAR2(80) UNIQUE NOT NULL,
senha_clie VARCHAR2(40) NOT NULL
);

--criando tabela produto
CREATE TABLE produto(
id_produto NUMBER(5) PRIMARY KEY NOT NULL,
nm_produto VARCHAR2(40) NOT NULL,
desc_produto VARCHAR2(80),
preco_produto NUMBER(6,2) NOT NULL,
estoque NUMBER(5) NOT NULL
);
--criando tabela forncedor
CREATE TABLE fornecedor(
id_fornecedor NUMBER(5) PRIMARY KEY NOT NULL,
cnpj_fornecedor NUMBER(14) UNIQUE NOT NULL,
nm_fornecedor VARCHAR2(50) NOT NULL,
email_fornecedor VARCHAR2(50)
);

--criando tabela categoria
CREATE TABLE categoria(
id_categoria NUMBER(5) PRIMARY KEY NOT NULL,
nm_categoria VARCHAR2(40) NOT NULL,
desc_categoria VARCHAR2(80)
);

--criando tabela interesses
CREATE TABLE interesses(
id_interesse NUMBER(5) PRIMARY KEY NOT NULL,
categoria_interesse VARCHAR2(40) NOT NULL,
nivel_interesse VARCHAR2(40)
);


--relação entre tabelas: 'itens_pedido'/'pedido'
ALTER TABLE itens_pedido
ADD id_pedido NUMBER(9);

ALTER TABLE itens_pedido
ADD CONSTRAINT fk_pedido_id FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido);

--relação entre tabelas: 'pedido'/'compra'
ALTER TABLE pedido
ADD id_compra NUMBER(9);

ALTER TABLE pedido
ADD CONSTRAINT fk_compra_id FOREIGN KEY (id_compra) REFERENCES compra (id_compra);

--relação entre tabelas: 'pedido'/'cliente'
ALTER TABLE pedido
ADD id_clie NUMBER(9);

ALTER TABLE pedido
ADD CONSTRAINT fk_cliente_id FOREIGN KEY (id_clie) REFERENCES cliente (id_clie);

--relação entre tabelas: 'compra'/'cliente'
ALTER TABLE compra
ADD id_clie NUMBER(9);

ALTER TABLE compra
ADD CONSTRAINT fk_cliente_id_compra FOREIGN KEY (id_clie) REFERENCES cliente (id_clie);

--relação entre tabelas: 'compra'/'nota_fiscal'
ALTER TABLE compra
ADD id_nota_fiscal NUMBER(9);

ALTER TABLE compra
ADD CONSTRAINT fk_nota_fiscal_id FOREIGN KEY (id_nota_fiscal) REFERENCES nota_fiscal (id_nota_fiscal);

--relação entre tabelas: 'cliente'/'interesses'
ALTER TABLE cliente
ADD id_interesse NUMBER(9);

ALTER TABLE cliente
ADD CONSTRAINT fk_interesses_id FOREIGN KEY (id_interesse) REFERENCES interesses (id_interesse);

--relação entre tabelas: 'interesses'/'categoria'
ALTER TABLE interesses
ADD id_categoria NUMBER(9);

ALTER TABLE interesses
ADD CONSTRAINT fk_categoria_id FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria);

--relação entre tabelas: 'categoria'/'produto'
ALTER TABLE produto
ADD id_categoria NUMBER(9);

ALTER TABLE produto
ADD CONSTRAINT fk_categoria_id_produto FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria);

--relação entre tabelas: 'produto'/'itens_pedido'
ALTER TABLE itens_pedido
ADD id_produto NUMBER(9);

ALTER TABLE itens_pedido
ADD CONSTRAINT fk_produto_id FOREIGN KEY (id_produto) REFERENCES produto (id_produto);

--relação entre tabelas: 'produto'/'fornecedor'
ALTER TABLE produto
ADD id_fornecedor NUMBER(9);

ALTER TABLE produto
ADD CONSTRAINT fk_fornecedor_id FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor);


--inserção de dados na tabela: nota_fiscal
INSERT INTO nota_fiscal (id_nota_fiscal, dt_emissao, valor_total) VALUES (1, '13-jul-2022', 220.00);
INSERT INTO nota_fiscal (id_nota_fiscal, dt_emissao, valor_total) VALUES (2, '07-mar-2023', 165.00);
INSERT INTO nota_fiscal (id_nota_fiscal, dt_emissao, valor_total) VALUES (3, '21-jul-2023', 320.00);
INSERT INTO nota_fiscal (id_nota_fiscal, dt_emissao, valor_total) VALUES (4, '19-jun-2024', 190.00);
INSERT INTO nota_fiscal (id_nota_fiscal, dt_emissao, valor_total) VALUES (5, '04-dez-2021', 270.00);

--inserção de dados na tabela: categoria
INSERT INTO categoria (id_categoria, nm_categoria, desc_categoria) VALUES (1, 'Roupas', 'Categoria de roupas em geral');
INSERT INTO categoria (id_categoria, nm_categoria, desc_categoria) VALUES (2, 'Calçados', 'Categoria de calçados em geral');
INSERT INTO categoria (id_categoria, nm_categoria, desc_categoria) VALUES (3, 'Acessórios', 'Categoria de acessórios em geral');
INSERT INTO categoria (id_categoria, nm_categoria, desc_categoria) VALUES (4, 'Bolsas e Mochilas', 'Categoria de bolsas e mochilas');
INSERT INTO categoria (id_categoria, nm_categoria, desc_categoria) VALUES (5, 'Óculos de Sol', 'Categoria de óculos de sol');

--inserção de dados na tabela: fornecedor
INSERT INTO fornecedor (id_fornecedor, cnpj_fornecedor, nm_fornecedor, email_fornecedor) VALUES (1, 12345678901234, 'Fornecedor 1', 'fornecedorA@email.com');
INSERT INTO fornecedor (id_fornecedor, cnpj_fornecedor, nm_fornecedor, email_fornecedor) VALUES (2, 23456789012345, 'Fornecedor 2', 'fornecedorB@email.com');
INSERT INTO fornecedor (id_fornecedor, cnpj_fornecedor, nm_fornecedor, email_fornecedor) VALUES (3, 34567890123456, 'Fornecedor 3', 'fornecedorC@email.com');
INSERT INTO fornecedor (id_fornecedor, cnpj_fornecedor, nm_fornecedor, email_fornecedor) VALUES (4, 45678901234567, 'Fornecedor 4', 'fornecedorD@email.com');
INSERT INTO fornecedor (id_fornecedor, cnpj_fornecedor, nm_fornecedor, email_fornecedor) VALUES (5, 56789012345678, 'Fornecedor 5', 'fornecedorE@email.com');

--inserção de dados na tabela: interesses
INSERT INTO interesses (id_interesse, categoria_interesse, nivel_interesse, id_categoria) VALUES (1, 'Roupas', 'Alto', 1);
INSERT INTO interesses (id_interesse, categoria_interesse, nivel_interesse, id_categoria) VALUES (2, 'Calçados', 'Médio', 2);
INSERT INTO interesses (id_interesse, categoria_interesse, nivel_interesse, id_categoria) VALUES (3, 'Acessórios', 'Baixo', 3);
INSERT INTO interesses (id_interesse, categoria_interesse, nivel_interesse, id_categoria) VALUES (4, 'Bolsas e Mochilas', 'Alto', 4);
INSERT INTO interesses (id_interesse, categoria_interesse, nivel_interesse, id_categoria) VALUES (5, 'Óculos de Sol', 'Médio', 5);

--inserção de dados na tabela: cliente
INSERT INTO cliente (id_clie, nm_clie, email_clie, endereco_clie, senha_clie, id_interesse) VALUES (1, 'João Silva', 'joao@email.com', 'Rua das Flores, 123', 'senha123', 1);
INSERT INTO cliente (id_clie, nm_clie, email_clie, endereco_clie, senha_clie, id_interesse) VALUES (2, 'Maria Santos', 'maria@email.com', 'Av. das Graças, 456', 'senha456', 2);
INSERT INTO cliente (id_clie, nm_clie, email_clie, endereco_clie, senha_clie, id_interesse) VALUES (3, 'Pedro Oliveira', 'pedro@email.com', 'Rua Sorriso, 789', 'senha789', 3);
INSERT INTO cliente (id_clie, nm_clie, email_clie, endereco_clie, senha_clie, id_interesse) VALUES (4, 'Ana Pereira', 'ana@email.com', 'Av. Felicidade, 1011', 'senha1011', 4);
INSERT INTO cliente (id_clie, nm_clie, email_clie, endereco_clie, senha_clie, id_interesse) VALUES (5, 'Carla Costa', 'carla@email.com', 'Rua Feliz, 1213', 'senha1213', 5);

--inserção de dados na tabela: compra
INSERT INTO compra (id_compra, data_compra, metodo_pagamento, id_clie, id_nota_fiscal) VALUES (1, '02-dez-2022', 'Cartão de crédito', 1, 1);
INSERT INTO compra (id_compra, data_compra, metodo_pagamento, id_clie, id_nota_fiscal) VALUES (2, '09-jul-2024', 'Boleto bancário', 2, 2);
INSERT INTO compra (id_compra, data_compra, metodo_pagamento, id_clie, id_nota_fiscal) VALUES (3, '27-jul-2023', 'Transferência bancária', 3, 3);
INSERT INTO compra (id_compra, data_compra, metodo_pagamento, id_clie, id_nota_fiscal) VALUES (4, '14-jun-2023', 'Cartão de débito', 4, 4);
INSERT INTO compra (id_compra, data_compra, metodo_pagamento, id_clie, id_nota_fiscal) VALUES (5, '11-jan-2022', 'Pix', 5, 5);

--inserção de dados na tabela: produto
INSERT INTO produto (id_produto, nm_produto, desc_produto, preco_produto, estoque, id_categoria, id_fornecedor) VALUES (1, 'Camiseta', 'Camiseta de algodão', 12.00, 25, 1, 1);
INSERT INTO produto (id_produto, nm_produto, desc_produto, preco_produto, estoque, id_categoria, id_fornecedor) VALUES (2, 'Calça Jeans', 'Calça jeans masculina', 20.00, 45, 1, 2);
INSERT INTO produto (id_produto, nm_produto, desc_produto, preco_produto, estoque, id_categoria, id_fornecedor) VALUES (3, 'Tênis Esportivo', 'Tênis para corrida', 30.00, 80, 2, 3);
INSERT INTO produto (id_produto, nm_produto, desc_produto, preco_produto, estoque, id_categoria, id_fornecedor) VALUES (4, 'Mochila', 'Mochila escolar', 35.00, 20, 4, 4);
INSERT INTO produto (id_produto, nm_produto, desc_produto, preco_produto, estoque, id_categoria, id_fornecedor) VALUES (5, 'Óculos de Sol', 'Óculos de sol unissex', 60.00, 18, 5, 5);

--inserção de dados na tabela: pedido
INSERT INTO pedido (id_pedido, dt_pedido, status_pedido, preco_total, id_compra, id_clie) VALUES (1, '10-dez-2024', 'Em andamento', 200.00, 1, 1);
INSERT INTO pedido (id_pedido, dt_pedido, status_pedido, preco_total, id_compra, id_clie) VALUES (2, '14-jul-2023', 'Concluído', 150.00, 2, 2);
INSERT INTO pedido (id_pedido, dt_pedido, status_pedido, preco_total, id_compra, id_clie) VALUES (3, '06-jan-2021', 'Em andamento', 300.00, 3, 3);
INSERT INTO pedido (id_pedido, dt_pedido, status_pedido, preco_total, id_compra, id_clie) VALUES (4, '11-nov-2022', 'Concluído', 180.00, 4, 4);
INSERT INTO pedido (id_pedido, dt_pedido, status_pedido, preco_total, id_compra, id_clie) VALUES (5, '19-jun-2024', 'Em andamento', 250.00, 5, 5);

--inserção de dados na tabela: itens_pedido
INSERT INTO itens_pedido (itens_id, quantidade_prod, preco, id_pedido, id_produto) VALUES (1, 3, 50.00, 1, 1);
INSERT INTO itens_pedido (itens_id, quantidade_prod, preco, id_pedido, id_produto) VALUES (2, 1, 20.00, 2, 2);
INSERT INTO itens_pedido (itens_id, quantidade_prod, preco, id_pedido, id_produto) VALUES (3, 2, 35.00, 3, 3);
INSERT INTO itens_pedido (itens_id, quantidade_prod, preco, id_pedido, id_produto) VALUES (4, 4, 10.00, 4, 4);
INSERT INTO itens_pedido (itens_id, quantidade_prod, preco, id_pedido, id_produto) VALUES (5, 2, 45.00, 5, 5);

