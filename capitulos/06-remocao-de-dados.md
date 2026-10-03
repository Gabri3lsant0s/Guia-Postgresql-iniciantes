# Capítulo 6 — Remoção de dados

## Objetivo

`DELETE` remove linhas. O `WHERE` funciona como o endereço no envelope: sem ele, o comando se aplica a todas as linhas da tabela.

## `DELETE` e `TRUNCATE`

- `DELETE FROM tabela WHERE condição` remove as linhas que correspondem ao filtro; sem `WHERE`, remove todas as linhas.
- `TRUNCATE TABLE tabela` esvazia a tabela inteira de forma eficiente. Pode reiniciar sequências com `RESTART IDENTITY`.
- No PostgreSQL, ambos participam de transações. `TRUNCATE` toma bloqueio mais forte e não dispara gatilhos `ON DELETE` por linha.
- `TRUNCATE` respeita dependências de chave estrangeira; `CASCADE` pode esvaziar tabelas relacionadas, então não o use sem avaliar o alcance.

## Prática

Execute `sql/06_remocao_de_dados.sql`. Primeiro o script consulta o cliente de teste que será excluído; em seguida, `DELETE ... RETURNING` mostra a linha removida. Depois, uma tabela temporária compara a exclusão de uma linha com o esvaziamento total.

Antes de remover dados reais, rode o mesmo filtro com `SELECT` e confirme os resultados. Em operações importantes, use uma transação para revisar antes de confirmar:

```sql
-- Inicia uma transação para que a remoção possa ser revisada antes de confirmar.
BEGIN;
-- Exclui apenas a linha que atende à condição especificada.
DELETE FROM clientes WHERE email = 'exemplo@example.com' RETURNING cliente_id;
-- Desfaz a alteração de exemplo em vez de gravá-la permanentemente.
ROLLBACK;
```

## Erros comuns e boas práticas

- Executar `DELETE FROM clientes;` sem `WHERE`: apaga todas as linhas.
- Usar `TRUNCATE` para “consertar” uma tabela sem conferir dependências.
- Confundir velocidade com segurança: comandos que limpam tudo exigem revisão extra.
- Esquecer que exclusões podem ser bloqueadas por chaves estrangeiras.
- Não usar `RETURNING` para confirmar quais linhas foram removidas.

## Exercícios

1. Antes do `DELETE`, por que o script executa um `SELECT` com o mesmo filtro?
2. Qual comando escolheria para excluir apenas um cliente? E para limpar por completo uma tabela de staging sem dependentes?
3. Qual é a diferença entre `ROLLBACK` e `COMMIT` após um `DELETE` dentro de uma transação?

### Gabarito comentado

1. O `SELECT` permite revisar as linhas atingidas antes da operação destrutiva.
2. `DELETE ... WHERE` para um cliente; `TRUNCATE TABLE` pode servir para esvaziar uma staging quando dependências e efeitos foram revisados.
3. `ROLLBACK` desfaz a transação; `COMMIT` confirma as alterações.
