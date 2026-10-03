# Capítulo 5 — Inserção de dados

## Objetivo

`INSERT` adiciona linhas às tabelas. Pense em cada linha como um formulário preenchido: informar as colunas pelo nome deixa claro onde cada valor será guardado.

## Conceitos

- `INSERT INTO ... VALUES` insere um ou vários conjuntos de valores.
- Omitir uma coluna permite que seu `DEFAULT` ou `IDENTITY` seja usado.
- `DEFAULT` pode ser informado explicitamente para solicitar o padrão da coluna.
- `RETURNING` devolve colunas das linhas inseridas; é uma extensão útil do PostgreSQL.
- `INSERT ... SELECT` carrega dados resultantes de uma consulta.
- `ON CONFLICT ... DO NOTHING` evita erro quando uma chave única já existe.

## Prática

Execute `sql/05_insercao_de_dados.sql` depois dos capítulos 3 e 4. O script insere clientes e produtos, carrega um produto por consulta e cria pedidos com itens. Os comentários explicam os CTEs usados para obter IDs automaticamente. Execute uma vez: os exemplos de clientes e produtos evitam duplicidade, mas cada execução cria novos pedidos.

Exemplo mínimo:

```sql
-- Insere um produto e retorna o identificador criado pelo banco.
INSERT INTO produtos (nome, preco, estoque)
VALUES ('Borracha', 2.00, 25)
RETURNING produto_id, nome;
```

O `id` Identity não aparece na lista de colunas: o PostgreSQL gera esse valor.

## Erros comuns e boas práticas

- Omitir a lista de colunas: se a ordem da tabela mudar, os valores podem não corresponder ao esperado. Informe sempre as colunas.
- Inserir uma chave estrangeira que não existe: primeiro deve existir o cliente/produto referenciado.
- Tratar `RETURNING` como sintaxe SQL universal: ele é um recurso do PostgreSQL.
- Reexecutar exemplos sem pensar em duplicidade: use chave única e conflito deliberado quando fizer sentido.
- Usar `ON CONFLICT DO NOTHING` para esconder qualquer problema: escolha explicitamente a chave que deve ser considerada duplicada.

## Exercícios

1. Insira um produto chamado `Régua`, com preço `4.75`, estoque `15` e SKU próprio; retorne seu ID.
2. Qual é a vantagem de `RETURNING` quando o banco gera o identificador?
3. No script, por que os pedidos buscam IDs por e-mail em vez de presumir valores como `1` e `2`?

### Gabarito comentado

1. Informe `nome`, `preco`, `estoque` e `sku` em `INSERT INTO produtos (...) VALUES (...) RETURNING produto_id;`. Inclua comentário descrevendo a intenção.
2. Ele devolve o identificador gerado na mesma operação, evitando uma consulta separada.
3. IDs Identity dependem do histórico da sequência e não devem ser presumidos. Buscar por e-mail único torna o exemplo independente do valor numérico.
