-- CAPÍTULO 4: INSERT, carga em lote e RETURNING.
-- Execute depois dos capítulos 3 e 4, uma vez no banco de estudos.

-- Insere clientes de exemplo, ON CONLICT evita repetir e-mail se reexecutado. 
INSERT INTO clientes (nome, email)
VALUES
    ('Ana Costa', 'ana@example.com'),
    ('Bruno Lima', 'bruno@example.com'),
    ('Cliente para exclusao', 'excluir@example.com')
ON CONFLICT (email) DO NOTHING;

-- Insere produtos com SKU único e mostra os IDs e preços sfetivamente gravados.
INSERT INTO produtos (nome, preco, estoque, sku, descricao)
VALUES
    ('Caderno', 19.90, 40, 'SKU-CAD-001', 'Capa azul, 100 folhas'),
    ('Caneta', 3.50, 100, 'SKU-CAN-001', 'Tinta azul')
ON CONFLICT (sku) DO NOTHING
RETURNING produto_id, nome, sku, preco

-- Usa DEFAULT apra pedir os calores padrão de estoque e status ativo.
INSERT INTO produtos (nome, preco, estoque, ativo, sku, descricao)
VALUES ('Lápis',1.25, DEFAULT, DEFAULT, 'SKU-LAP-001', 'Lápis grafite')
RETURNING produto_id, nome, estoque, ativo;

-- Carga via consulta: incluio marcador apenas se seu SKU ainda não existir.
INSERT INTO produtos (nome, preco, estoque, sku, descricao)
SELECT 'Marcador', 5.25, 30, 'SKU-MAR-001', 'Marcador colorida'
WHERE NOT EXISTS (
    SELECT 1 
    FROM produtos 
    WHERE sku = 'SKU-MAR-001'
)
RETURNING produto_id, nome;

-- Insere dosi pedidos e sues itens usansdo consultas para buscar as chaves geradas.
-- Os CTEs nomeiem etapas intermediárias sem exigir que você copie IDs à mão.
WITH clientes_escolhidos AS (
    -- Localiza os clientes pelas chaves naturais únicas(email)
     SELECT clienteç_id, email
     FROM clientes
     WHERE email IN ('ana@example.com', 'bruno@example.com')
), pedidos_novos AS (
    -- Cria um peiddo para cada cliente encontrado e devolve as chaves geradas.
    INSERT INTO pedidos (cliente_id)
    SELECT cliente_id
    FROM clientes_escolhidos
    RETURNING pedido_id, cliente_id
), linhas AS (
    --Define fois produtos e suas qauntidades para cada pedido novo.
    SELECT pedido_novo.pedido_id, produto.produto_id, produto.preco,
        CASE produto.sku
            WHEN 'SKU-CAD-001' THEN 2
            ELSE 1
        END AS quantidade
        FROM pedidos_novos AS pedido_novo
        JOIN produtos AS produto 
        ON produto.sku IN ('SKU-CAD-001', 'SKU-CAN-001')
)
-- Grava as linhas do pedido e devolber um resumo do que foi inserido.
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
SELECT pedido_id, produto_id, quantidade, preco
FROM linhas
RETURNING pedido_id, produto_id, quantidade, preco_unitario;