SET SERVEROUTPUT ON;
--executa a chamada função que verifica se o email ja existe na tabela cliente
DECLARE
  email_valido BOOLEAN;
BEGIN
  email_valido := validar_email_cliente('maria@email.com');
  IF email_valido THEN
    dbms_output.put_line('Email não existe');
  ELSE
    dbms_output.put_line('Email já existe.');
  END IF;
END;
/

--executa a chamada função que verifica se um cliente já fez um pedido dentro de um intervalo de tempo especificado
DECLARE
  v_resultado BOOLEAN;
BEGIN
  --verifica se o cliente (id = 1)  fez um pedido nos últimos 30 dias
  v_resultado := validar_pedido_recente(1, 30);

  IF v_resultado THEN
    dbms_output.put_line('Não há pedidos recentes.');
  ELSE
    dbms_output.put_line('Há pedidos recentes.');
  END IF;
END;
/

--executa a chamada da procedure de insert na tabela cliente
BEGIN
    inserir_cliente(13, 'julio', 'angelo@email.com', 'ruua dos anjos', 'iofuawejna213321@', 5);
END;
/
SELECT * FROM cliente;
/


--executa a chamada da procedure de update na tabela cliente
BEGIN
    atualizar_cliente(1, 'isabel', 'isabel@email.com', 'rua das cabras, 123', 'hdabduiasb¨7&', 3);
END;
/
SELECT * FROM cliente;
/

--executa a chamada da procedure de delete na tabela cliente
BEGIN
    excluir_cliente(13);
END;
/
SELECT * FROM cliente;
/

/*
executa a chamada da procedure "detalhes_pedido_cliente" em que a partir do id do cliente,
trás informações dos pedidos dos clientes, e os detalhes dos produtos.
*/
BEGIN
    detalhes_pedido_cliente(3);
END;
/


--executa a chamada da procedure "relatorio_vendas_por_categoria", mostrando o total de vendas e preço médio dos produtos por categoria.
BEGIN
    relatorio_vendas_por_categoria;
END;









