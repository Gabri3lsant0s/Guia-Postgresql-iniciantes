# Capítulo 1 — Sua primeira consulta

Neste primeiro passo, vamos apenas enviar uma consulta ao PostgreSQL e ler a resposta. Ainda não precisamos criar tabelas.

## Ideia principal

`SELECT` é usado para pedir um resultado ao banco. Podemos pedir um valor direto, sem que ele esteja salvo em uma tabela.

Imagine uma pergunta simples: “PostgreSQL, devolva este texto para mim”.

## Pratique

Abra `sql/01_primeiros_passos.sql` e execute uma consulta por vez. Antes de executar, leia os comentários e tente adivinhar o resultado.

```sql
-- Pede ao PostgreSQL que devolva um texto.
-- AS mensagem define o título da coluna no resultado.
SELECT 'Olá, PostgreSQL!' AS mensagem;
```

O resultado será uma coluna chamada `mensagem` com o texto `Olá, PostgreSQL!`.

Agora veja outro valor que o banco pode fornecer:

```sql
-- Retorna a data atual conhecida pelo servidor PostgreSQL.
SELECT CURRENT_DATE AS data_de_hoje;
```

## Seu exercício

No arquivo SQL, altere o texto da consulta de desafio para incluir seu nome. Execute novamente e observe o resultado. Não remova os comentários: eles explicam a intenção do código para outra pessoa que abrir o arquivo.

## O que aprendemos

- `SELECT` solicita um resultado.
- Textos são escritos entre aspas simples.
- `AS` escolhe o nome exibido para uma coluna.
- `--` inicia um comentário SQL; o banco ignora essa linha ao executar o script.
