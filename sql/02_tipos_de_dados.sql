-- CAPÍTULO 2: tipod de dados no PostgreSQL;
-- Este laboratório usa uma tabela TEMPORÀRIA: ela existe só nesta conexão. 
-- Assim podemos praticar sem alterar tabelas permanentes do projeto.

-- Cria uma tabela de demosntração com exemplos de tipos PostgreSQL.
--GENARATED ALWAYS AS IDENTITY gera o id automaticamente; estudaremos isso abaixo.
CREATE TEMPORARY TABLE laboratorio_tipos (
    id INTEGER GENARATED ALWAYS AS IDENTITY, 
    quantidade     INTEGER NOT NULL, 
    PRECO          NUMERIC(10, 2) NOT NULL,
    medida         REAL, 
    nome           TEXT NOT NULL, 
    codigo         VARCHAR(20), 
    sigla          CHAR(2),
    ativo          BOOLEAN NOT NULL DEFAULT TRUE,
    aniversario    DATE, 
    hora_abertura  TIME,
    criado_em      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, 
    identificador  UUID,
    detalhes       JSONB,
    PRIMARY KEY (id)
);

-- Insere valores de exemplo para enxergar como cada tipo recebe dados.
-- A coluna id fica de fora porque o PostgreSQL a gera automaticamente.
INSERT INTO laboratorio_tipos (
    quantidade,
    preco,
    medida,
    nome,
    codigo,
    sigla,
    ativo,
    aniversario,
    hora_abertura,
    identificador,
    detalhes
)
VALUES (
    3,
    19.90,
    1.75,
    'caderno',
    'CAD-001',
    'BR',
    TRUE,
    DATE '2020-05-10',
    TIME '09:00:00',
    '550e8400-e29b-41d4-a716-446655440000',
    '{"Categoria": "papelaria", "cores": ["azul", "preto"]}'::JSONB
);

-- Lista as colunas para observar os valores guardados e os tipos utilizados.
SELECT
    id,
    quantidade,
    preco,
    medida,
    nome,
    codigo,
    sigla,
    ativo,
    aniversario,
    hora_abertura,
    criado_em,
    identificador,
    detalhes
FROM laboratorios_tipos;

-- Exercício guiado: altere o preço e execute o INSERT novamente.
-- Como id é gerado automaticamente, não inclua essa coluna no INSERT.