-- CAPÍTULO 4: ALTER TABLE e dependência.
-- O laboratúrio usa uma tabela temporária para praticar sem mudar as tabelas da loja.

-- Adiciona ao catálogo a descrição opcional usada nos exemplos de inserção.
ALTER TABLE produtos
    ADD COLUMN descricao TEXT

-- Adiciona um SKU variável para identificar o produto fora do banco.
ALTER TABLE produtos
    ADD COLUMN sku VARCHAR(30);

-- Garante que cada SKU preenchido identifique apenas um produto.
ALTER TABLE produtos
    ADD CONSTRAINT uq_produtos_sku UNIQUE (sku);

-- Cria uma tabela temporária para praticar a alteração de estruturas.
CREATE TEMPORARY TABLE laboratorio_alteracao (
    laboratorio_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome TEXT NOT NULL
);

-- Adiciona uma coluna opcional, linhas existentes receberiam NULL.
ALTER TABLE laboratorio_alteracao
    ADD COLUMN observacao TEXT;

-- Altera o tipo da coluna para impor um limite de tamnanho.
ALTER TABLE laboratorio_alteracao
    ALTER COLUMN nome TYPE VARCHAR(80);

-- Adiciona uma regra nomeada que aceita apenas nomes não vazios.
ALTER TABLE laboratorio_alteracao
    ADD CONSTRAINT chk_laboratorio_nome CHECK (length(trim(nome)) > 0);

-- Remove a regra de demonstração pelo nome para msotrar DROP CPNSTRAINT.
ALTER TABLE laboratorio_alteracao
    DROP CONSTRAINT chk_laboratorio_nome; 

-- Remove a coluna cirada no exercício; confirme antes de remover dados reais.
ALTER TABLE laboratorio_alteracao
    DROP COLUMN observacao;

-- Remove somente a tabela temporária deste laboratório.
DROP TABLE laboratorio_alteracao RESTRICT;

-- Exemplo conceitual: CASCADE também remove objetos dependentes; revise antes de usar.
-- DROP TABLE nome_da_tabela CASCADE;
