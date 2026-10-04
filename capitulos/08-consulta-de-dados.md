# Capítulo 8 — Seleção e consulta de dados

## Objetivo

`SELECT` consulta dados sem alterar as linhas. Imagine pedir à loja uma lista filtrada, ordenada e resumida do que existe no estoque.

## Estrutura básica e filtros

Uma consulta costuma seguir esta forma:

```sql
-- Seleciona colunas e linhas específicas de uma tabela.
SELECT nome, preco
FROM produtos
WHERE ativo = TRUE;
```

- `WHERE` filtra linhas.
- `AND` exige que as duas condições sejam verdadeiras; `OR` aceita uma ou outra. Use parênteses quando misturar ambos.
- `LIKE` compara texto com curingas: `%` representa zero ou mais caracteres e `_` representa um caractere.
- `ILIKE` é a variação PostgreSQL que ignora maiúsculas/minúsculas.
- `IN` compara contra uma lista de valores.
- `BETWEEN` seleciona um intervalo incluindo os limites.

## Ordenação e paginação

`ORDER BY coluna ASC` ordena de forma crescente; `DESC` decrescente. `LIMIT` limita a quantidade de linhas. `OFFSET` pula linhas antes de devolver o resultado.

Sempre ordene quando o resultado precisa ser previsível. Em paginação real com muitas alterações simultâneas, prefira paginação por chave (keyset) a grandes `OFFSET`s.

## Agregações e agrupamentos

`COUNT` conta, `SUM` soma e `AVG` calcula a média. `GROUP BY` forma grupos antes de calcular agregações; `HAVING` filtra grupos depois da agregação. `WHERE` filtra linhas antes do agrupamento.

## Junções

- `INNER JOIN` retorna combinações com correspondência nas duas tabelas.
- `LEFT JOIN` retorna todas as linhas da tabela à esquerda e preenche com `NULL` quando não há correspondência à direita.

No script, os aliases (`cliente`, `pedido`, `produto`) encurtam nomes e deixam claro de qual tabela vem cada coluna. As condições `ON` ligam chaves relacionadas.

## Prática

Execute `sql/08_consulta_de_dados.sql` depois dos capítulos 3 a 7. Compare a consulta `LEFT JOIN` com a consulta usando `INNER JOIN`: a primeira também mostra clientes sem pedidos; a segunda exige correspondência.

## Erros comuns e boas práticas

- Esquecer a condição `ON` de um `JOIN`: pode produzir combinações excessivas entre linhas.
- Usar `WHERE` para filtrar o resultado de uma agregação: use `HAVING` para filtrar grupos.
- Selecionar colunas sem agrupá-las nem agregá-las: cada coluna selecionada em uma consulta agrupada precisa ser compatível com o agrupamento.
- Esperar ordem sem `ORDER BY`: o banco não garante uma ordem implícita.
- Usar `LIMIT/OFFSET` sem ordenação estável: páginas podem repetir ou pular linhas.
- Usar `SELECT *` em relatórios permanentes: liste apenas as colunas necessárias.

## Exercícios

1. Liste produtos ativos com preço menor que 10, do mais barato ao mais caro.
2. Conte quantos pedidos existem por status e mostre apenas grupos com pelo menos dois pedidos.
3. Liste todos os clientes e seus pedidos, incluindo clientes sem pedidos. Qual junção usar?

### Gabarito comentado

1. Filtre `ativo = TRUE AND preco < 10` e ordene por `preco ASC`.
2. Use `COUNT(*)`, `GROUP BY status` e `HAVING COUNT(*) >= 2`.
3. Use `LEFT JOIN` partindo de `clientes`, pois ele preserva todas as linhas da tabela à esquerda.
