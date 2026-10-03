# Capítulo 3 — Criação e estruturação de tabelas

## Objetivo

Vamos transformar o desenho de uma pequena loja em tabelas reais. Pense nas restrições como regras na entrada de um prédio: elas impedem que dados inválidos passem e mantenham o banco consistente.

## Conceitos

- `CREATE TABLE` cria uma tabela com suas colunas e regras.
- `NOT NULL` exige um valor.
- `DEFAULT` fornece um valor quando o `INSERT` não informa a coluna.
- `UNIQUE` impede valores repetidos, como e-mails.
- `CHECK` valida uma condição, como preço maior ou igual a zero.
- `PRIMARY KEY` identifica cada linha de forma única e não aceita `NULL`.
- `FOREIGN KEY` exige que o valor referenciado exista em outra tabela.

O exemplo usa quatro tabelas: clientes, produtos, pedidos e itens do pedido. Um pedido pertence a um cliente; seus itens apontam para produtos. As chaves estrangeiras mantêm essas relações válidas.

## Prática

Leia os comentários e execute `sql/03_criacao_de_tabelas.sql` uma vez no banco de estudos. A ordem importa: as tabelas referenciadas precisam existir antes das tabelas que apontam para elas. `IDENTITY` gera identificadores; não os invente manualmente.

O script nomeia as restrições. Nomes claros facilitam entender mensagens de erro e alterar regras depois.

## Erros comuns e boas práticas

- Criar uma chave estrangeira antes da tabela referenciada: siga a ordem do script.
- Usar `UNIQUE` sem pensar no significado: e-mail pode ser único no exemplo, mas nomes de pessoas não precisam ser.
- Confundir `CHECK` com `NOT NULL`: um `CHECK` não rejeita `NULL` por si só; use `NOT NULL` quando a ausência for proibida.
- Escolher exclusão em cascata sem avaliar o efeito: aqui apagar pedido remove seus itens, mas apagar cliente com pedido é bloqueado.
- Executar o script novamente: `CREATE TABLE` dará erro se as tabelas já existirem. Não apague tabelas para “resolver” sem entender os dados dependentes.

## Exercícios

1. Qual regra impede que dois clientes usem o mesmo e-mail?
2. O que acontece se você tentar criar um pedido com `cliente_id` inexistente?
3. Explique por que a chave primária de `itens_pedido` tem duas colunas.

### Gabarito comentado

1. `UNIQUE (email)` impede duplicidade.
2. A chave estrangeira rejeita o pedido porque o cliente referenciado não existe.
3. Um mesmo produto pode aparecer em pedidos diferentes; o par pedido/produto identifica cada linha do pedido.
