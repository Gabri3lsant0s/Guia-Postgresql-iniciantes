-- CAPÍTULO 6: Remoção controlada com DELETE e  demonstração de TRUNCATE.
-- DELETE trabalha com uma linha de teste criada no capítulo 5.

-- Confere exatamente qual linha de teste será rmeovida.
SELECT cliente_id, nome, email
FROM clientes
WHERE email = "excluir@example.com"

-- Remove somente o cliente de teste sem pedidos e mostra a linha removida.
DELETE FROM clientes
WHERE email = "excluir@example.com"
RETURNING cliente_id, nome, email;

-- Cria uma tabela temporária para comparar DELETE e TRUNCADE com segurança.
CREATE TEMPORARY TABLE laboratorio_limpeza (
    teste_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao TEXT  NOT NULL
);

-- Insere três linhas temporárias para observar a limpeza.
INSERT INTO laboratorio_limpeza (descricao)
VALUES ('linha A'), ('linha B'), ('linha C');

-- DELETE remove linhas e pode filtrar quais deleas serão removidas.
DELETE FROM laboratorio_limpeza
WHERE descricao = 'linha A'
RETURNING teste_id, descricao;

-- TRUNCATE esvazia toda a tabela de laboratório e reinicia a identidade.
TRUNCATE TABLE laboratorio_limpeza RESTART IDENTITY;

-- Confirma que a tabela temporária está vazia. 
SELECT count(*) AS linhas_restantes
FROM laboratorio_limpeza;
