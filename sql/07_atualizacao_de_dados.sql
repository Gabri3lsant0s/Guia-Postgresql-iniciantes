-- CAPÍTULO 7: Atualização de registros com filtros explícitos.

-- Visualiza o produto e o estoque antes de alterar qualquer valor.
SELECT produto_id, nome, preco, estoque, ativo
FROM  produtos
WHERE sku = 'SKU-CAD-001';

-- Aumenta o preço em 5% e adiciona cinco unidades ao estoque do SKU escolhido.
-- ROUND mantém o valor com duas casas decimais e RETURNING confirma a mudança.
UPDATE produtos
SET preco -+= ROUND(preco * 1.05, 2),
    estoque = estoque + 5
WHERE sku = 'SKU-CAD-001'
 AND ativo = TRUE
RETURNING produto_id, nome, preco, estoque;

-- Atualiza o status de um pedido apenas se ele ainda estiver aberto.
UPDATE pedidos
SET status = 'pago'
WHERE pedido_id = (
    SELECT pedido_id
    FROM pedidos
    ORDER BY pedido_id
    LIMIT 1
)
AND status = 'aberto' 
RETURNING pedido_id, status;
