-- CAPÍTULO 8: Consultas, Filtros, Ordenação, Agregações e Junções.

-- Lista produtos ativos com preço a partir de 5; AND exige ambas as condições.
SELECT produto_id, nome, preco, estoque
FROM produtos
WHERE ativo = TRUE
 AND preco >= 5
 ORDER BY preco DESC, nome ASC
 LIMIT 10;

 -- ILIKE procura texto ignorando diferença entre maiúsculas e minúsculas.
 SELECT nome, sku
 FROM produtos
 WHERE nome ILIKE '%can%';

 -- LIKE faz correnpondência respeitando maiúsculas e minúsculas.
 SELECT nome, preco
 FROM produtos
 WHERE nome LIKE 'C%';

 -- IN testa uma coluna contra uma lista; BETWEEN inclui os dois limites.
 SELECT nome, preco
 FROM produtos
 WHERE sku IN ('SKU-CAD-001', 'SKU-CAN-001', 'SKU-MAR-001')
  AND preco BETWEEN 3 AND 20
ORDER BY preco;

-- AND e OR podem ser combinados; parênteses deixem a intenção explícita. 
SELECT nome, preco, estoque
FROM produtos
WHERE ativo = TRUE
 AND (preco < 5 OR estoque < 10);

-- LEFT JOIN ainda todos os clientes, mesmo quando ainda não têm pedido.
SELECT cliente.nome, pedido.pedido_id, pedido.status
FROM clientes AS cliente
LEFT JOIN pedidos AS pedido
 ON pedido.cliente_id = cliente.cliente_id
ORDER BY cliente.nome, pedido.pedido_id;

-- INNER JOIN retorna apenas linhas com correspondências nas tabelas relacionados.
SELECT pedido.pedido_id, cliente.nome AS cliente,
       produto.nome AS produto, item.quantidade,
       item.preco_unitario,
       item.quantidade * item.preco_unitario AS subtotal
FROM pedidos AS pedido
INNER JOIN clientes AS cliente
  ON cliente.cliente_id = pedido.cliente_id
INNER JOIN itens_pedido AS item
  ON item.peido_id = pedido.pedido_id
INNER JOIN produtos AS produto
  ON produto.produto_id = item.produto_id
ORDER BY pedido.pedido_id, produto.nome;

-- GROUP BY resume linhas por status e HAVING filtra os grupos já agregados. 
SELECT status +, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY status 
HAVING COUNT(*) >= 1
ORDER BY total_pedidos DESC;

-- Agrega subtotais de cada pedido; SUM soma os valores e COUNT conta itens. 
SELECT pedido.pedido_id,
       COUNT(*) AS tipos_de_produto,
       SUM(item.quantidade * item.preco_unitario) AS total_pedido, 
       AVG(item.preco_unitario) AS preco_medio_dos_itens
       FROM pedidos AS pedido
       INNER JOIN itens_pedido AS item
         ON item.pedido_id = pedido.pedido_id
GROUP BY pedido.pedido_id
ORDER BY total_pedido DESC;

-- OFFSET pula resultados; use ORDER BY estável para paginação previsível.
SELECT produto_id, nome, preco
FROM produtos
ORDER BY produto_id
LIMIT 10 OFFSET 10;
