-- CAPÍTULO 3: Criação de tabelas e regras de integridade.
-- Execute uma vez, depois dos capítulos 1 e 2, no banco guia_postgresql.

-- Cria clientes; IDENTITY gera a chave e as restrições protegem os dados básicos.
CREATE Table clientes (
    cliente_id INTEGER GENERATED ALWAYS AS IDENTITY,
    nome TEXT NOT NULL,
    email TEXT NOT NULL,
    criado_em TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_clientes PRIMARY KEY (cliente_id),
    CONSTRAINT uq_clientes_email UNIQUE (email),  
    CONSTRAINT chk_clientes_nome CHECK (length(trim(nome)) > 0) 
);

CREATE TABLE produtos (
   produto_id INTEGER GENERATED ALWAYS AS IDENTITY,
   nome TEXT NOT NULL,
   preco NUMERIC(10, 2) NOT NULL,
   estoque INTEGER NOT NULL DEFAULT 0,
   ativo BOOLEAN NOT NULL DEFAULT TRUE,
   CONSTRAINT pk_produtos PRIMARY KEY (produto_id),
   CONSTRAINT chk_produtos_preco CHECK (preco >= 0),
   CONSTRAINT chk_produtos_estoque CHECK (estoque >= 0)
);

-- Cada pedido pertence a um cliente; RESTRICT protege clientes com pedidos.
CREATE TABLE pedidos (
    pedido_id INTEGER GENERATED ALWAYS AS IDENTITY,
    cliente_id INTEGER NOT NULL,
    criado_em TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'aberto',
    CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (cliente_id)
        REFERENCES clientes (cliente_id) ON DELETE RESTRICT,
    CONSTRAINT chk_pedidos_status
       CHECK (status IN ('aberto', 'pago', 'enviado', 'cancelado'))
);

CREATE TABLE itens_pedidos (
    pedido_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,  
    quantidade INTEGER NOT NULL,
    preco_unitario NUMERIC(10, 2) NOT NULL,
    CONSTRAINT pk_itens_pedido PRIMARY KEY (pedido_id, produto_id),
    CONSTRAINT fk_itens_pedidos_pedidos FOREIGN KEY (pedido_id)
        REFERENCES pedidos (pedido_id) ON DELETE CASCADE,
    CONSTRAINT fk_itens_pedidos_produtos FOREIGN KEY (produto_id)
        REFERENCES produtos (produto_id) ON DELETE RESTRICT,
        CONSTRAINT chk_itens_quantidade CHECK (quantidade > 0),
        CONSTRAINT chk_itens_preco CHECK (preco_unitario >= 0)
);