# Capítulo 4 — Modificação e remoção de estruturas

## Objetivo

Depois que uma tabela existe, requisitos podem mudar. `ALTER TABLE` é como reformar uma sala ocupada: primeiro entenda o que será afetado, especialmente quando há dados ou objetos dependentes.

## Conceitos e prática

O script `sql/04_alteracao_de_tabelas.sql` adiciona `descricao` e `sku` à tabela permanente `produtos`, cria a regra de SKU único e usa uma tabela temporária para demonstrar outras operações. Execute uma vez, depois do Capítulo 3. As colunas adicionadas serão usadas nos capítulos seguintes.

Na tabela temporária, o script pratica:

- `ADD COLUMN` adiciona uma coluna.
- `ALTER COLUMN ... TYPE` muda o tipo.
- `ADD CONSTRAINT` acrescenta uma regra.
- `DROP CONSTRAINT` remove uma regra pelo nome.
- `DROP COLUMN` remove uma coluna e seus dados.
- `DROP TABLE` remove uma tabela.

Ao fechar a conexão, a tabela temporária desaparece. As alterações em `produtos` permanecem. Não repita o script sem antes entender que as colunas e a restrição já terão sido criadas.

## `RESTRICT` e `CASCADE`

`RESTRICT` bloqueia a remoção se houver objetos dependentes. `CASCADE` remove também dependências que o PostgreSQL identificar. É como remover uma parede: `RESTRICT` impede se houver estrutura apoiada nela; `CASCADE` derruba também o que depende dela.

Por segurança, o script executa `DROP TABLE ... RESTRICT` apenas sobre a tabela temporária. O exemplo com `CASCADE` fica comentado para não executar por acidente.

## Erros comuns e boas práticas

- Remover uma coluna sem verificar seu conteúdo: `DROP COLUMN` descarta os dados daquela coluna.
- Usar `CASCADE` para contornar um erro sem saber quais objetos serão removidos.
- Alterar o tipo sem considerar conversão e valores existentes.
- Esquecer o nome da restrição: nomeie regras importantes ao criá-las.
- Executar script de alteração repetidamente: algumas operações não são idempotentes e falham quando coluna ou tabela já foi removida.

## Exercícios

1. Qual comando adiciona a coluna `observacao` no laboratório?
2. Qual a diferença prática entre `RESTRICT` e `CASCADE` ao remover uma tabela?
3. Por que o script remove uma tabela temporária em vez de apagar `clientes`?

### Gabarito comentado

1. `ALTER TABLE laboratorio_alteracao ADD COLUMN observacao TEXT;` adiciona a coluna.
2. `RESTRICT` impede a remoção se houver dependências; `CASCADE` remove objetos dependentes também.
3. A tabela temporária permite praticar alterações sem risco de apagar dados permanentes do projeto.
