-- função que verifica se o email fornecido já existe na tabela cliente.

CREATE OR REPLACE FUNCTION validar_email_cliente(email_cliente IN VARCHAR2)
  RETURN BOOLEAN
IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_count
  FROM cliente
  WHERE email_clie = email_cliente;
  
  IF v_count > 0 THEN
    RETURN FALSE;
  ELSE
    RETURN TRUE;
  END IF;
END validar_email_cliente;
/

-- função que verifica se um cliente já fez um pedido dentro de um intervalo de tempo especificado.
CREATE OR REPLACE FUNCTION validar_pedido_recente(id_cliente IN NUMBER, intervalo_dias IN NUMBER)
  RETURN BOOLEAN
IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_count
  FROM pedido
  WHERE id_clie = id_cliente
  AND dt_pedido >= sysdate - intervalo_dias;
  
  IF v_count > 0 THEN
    RETURN FALSE; 
  ELSE
    RETURN TRUE; 
  END IF;
END validar_pedido_recente;
/


-- procedure de insert para a tabela cliente
CREATE OR REPLACE PROCEDURE inserir_cliente(
    id_cliente IN NUMBER,
    nome_cliente IN VARCHAR2,
    email_cliente IN VARCHAR2,
    endereco_cliente IN VARCHAR2,
    senha_cliente IN VARCHAR2,
    id_interesse IN NUMBER
)
IS
BEGIN
    INSERT INTO cliente (id_clie, nm_clie, email_clie, endereco_clie, senha_clie, id_interesse)
    VALUES (id_cliente, nome_cliente, email_cliente, endereco_cliente, senha_cliente, id_interesse);
    
    dbms_output.put_line('Cliente inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro ao inserir cliente: ' || sqlerrm);
END inserir_cliente;
/

-- procedure de update para a tabela cliente
CREATE OR REPLACE PROCEDURE atualizar_cliente(
    id_cliente IN NUMBER,
    nome_cliente IN VARCHAR2,
    email_cliente IN VARCHAR2,
    endereco_cliente IN VARCHAR2,
    senha_cliente IN VARCHAR2,
    id_interesse IN NUMBER
)
IS
BEGIN
    UPDATE cliente
    SET nm_clie = nome_cliente,
        email_clie = email_cliente,
        endereco_clie = endereco_cliente,
        senha_clie = senha_cliente,
        id_interesse = id_interesse
    WHERE id_clie = id_cliente;
    
    COMMIT;
    dbms_output.put_line('Cliente atualizado com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro ao atualizar cliente: ' || sqlerrm);
END atualizar_cliente;
/

-- procedure de delete para a tabela cliente
CREATE OR REPLACE PROCEDURE excluir_cliente(id_cliente IN NUMBER)
IS
BEGIN
    DELETE FROM cliente WHERE id_clie = id_cliente;
    
    COMMIT;
    dbms_output.put_line('Cliente excluído com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro ao excluir cliente: ' || sqlerrm);
END excluir_cliente;
/

/*
procedure que usa um cursor para fazer um join entre as tabelas "pedido" e "itens_pedido", 
em que bsuca informações sobre os pedidos de um cliente, com detalhes dos produtos comprados.
*/

CREATE OR REPLACE PROCEDURE detalhes_pedido_cliente(
    id_cliente IN NUMBER
)
IS
    CURSOR pedido_cursor IS
        SELECT P.id_pedido, P.dt_pedido, P.status_pedido, ip.quantidade_prod, ip.preco, pr.nm_produto
        FROM pedido P
        JOIN itens_pedido ip ON P.id_pedido = ip.id_pedido
        JOIN produto pr ON ip.id_produto = pr.id_produto
        WHERE P.id_clie = id_cliente;
        
    v_pedido_id pedido.id_pedido%TYPE;
    v_data_pedido pedido.dt_pedido%TYPE;
    v_status_pedido pedido.status_pedido%TYPE;
    v_qtd_produto itens_pedido.quantidade_prod%TYPE;
    v_preco itens_pedido.preco%TYPE;
    v_nome_produto produto.nm_produto%TYPE;
BEGIN
    OPEN pedido_cursor;
    
    LOOP
        FETCH pedido_cursor INTO v_pedido_id, v_data_pedido, v_status_pedido, v_qtd_produto, v_preco, v_nome_produto;
        EXIT WHEN pedido_cursor%notfound;
        
        dbms_output.put_line('Pedido ID: ' || v_pedido_id);
        dbms_output.put_line('Data do Pedido: ' || v_data_pedido);
        dbms_output.put_line('Status do Pedido: ' || v_status_pedido);
        dbms_output.put_line('Quantidade do Produto: ' || v_qtd_produto);
        dbms_output.put_line('Preço: ' || v_preco);
        dbms_output.put_line('Nome do Produto: ' || v_nome_produto);
    END LOOP;
    
    CLOSE pedido_cursor;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro ao buscar detalhes do pedido: ' || sqlerrm);
END detalhes_pedido_cliente;
/

/*
procedure que gera um relatório de vendas por categoria de produto, incluindo o total de vendas e preço médio dos produtos em cada categoria.
foi usado o INNER JOIN entre as tabelas "categoria", "produto" e "itens_pedido" para obter informações sobre as vendas por categoria e os métodos SUM e COUNT 
para calcular o total de vendas e preço médio respectivamente, dos produtos por categoria. a regra de negócio foi implementada através do HAVING 
que garante que apenas categorias com pelo menos uma venda sejam incluídas no relatório, e os resultados são ordenados pelo total de vendasem ordem decrescente.
*/

CREATE OR REPLACE PROCEDURE relatorio_vendas_por_categoria
IS
BEGIN
    -- Cursor para obter o relatório de vendas por categoria
    FOR categoria_rec IN (
        SELECT C.nm_categoria, COUNT(ip.id_pedido) AS total_vendas, 
               AVG(pr.preco_produto) AS preco_medio
        FROM categoria C
        JOIN produto pr ON C.id_categoria = pr.id_categoria
        JOIN itens_pedido ip ON pr.id_produto = ip.id_produto
        GROUP BY C.nm_categoria
        HAVING COUNT(ip.id_pedido) > 0
        ORDER BY total_vendas DESC
    )
    LOOP
        dbms_output.put_line('Categoria: ' || categoria_rec.nm_categoria);
        dbms_output.put_line('Total de Vendas: ' || categoria_rec.total_vendas);
        dbms_output.put_line('Preço Médio dos Produtos: ' || categoria_rec.preco_medio);
        dbms_output.put_line('--------------------------------------------');
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro ao gerar o relatório de vendas por categoria: ' || sqlerrm);
END relatorio_vendas_por_categoria;






