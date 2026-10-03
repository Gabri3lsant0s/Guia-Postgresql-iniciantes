# Capítulo 7 — Atualização de dados

## Objetivo

`UPDATE` altera linhas existentes. Pense nele como corrigir campos de um formulário já arquivado: o `SET` descreve a nova informação e o `WHERE` identifica quais formulários serão alterados.

## Conceitos e prática

O formato geral é:

```sql
-- Atualiza o valor de uma coluna apenas nas linhas que passam pelo filtro.
UPDATE nome_da_tabela
SET coluna = novo_valor
WHERE condição;
```

Sem `WHERE`, todas as linhas são atualizadas. O script `sql/07_atualizacao_de_dados.sql` primeiro consulta o produto, depois altera preço e estoque com expressões baseadas nos valores atuais. `RETURNING` mostra o resultado.

Execute o script depois do Capítulo 5. Ele muda os dados de estudo, então observe o estado antes e depois. Você pode executar novamente para ver a atualização aplicada outra vez.

## Erros comuns e boas práticas

- Esquecer `WHERE`: a instrução modifica toda a tabela.
- Atualizar apenas pelo nome: nomes podem se repetir; prefira chave primária ou chave única.
- Sobrescrever valores sem consultar antes: revise o filtro com `SELECT`.
- Atualizar colunas dependentes em comandos diferentes quando devem permanecer coerentes: use um único `UPDATE` com várias atribuições.
- Não avaliar fórmulas: `estoque = estoque + 5` é diferente de `estoque = 5`.

## Exercícios

1. Altere o estoque do produto `SKU-CAN-001` adicionando 10 unidades, sem substituir o estoque atual.
2. Atualize preço e estoque no mesmo comando e use `RETURNING` para conferir ambos.
3. Que risco existe em executar `UPDATE produtos SET ativo = FALSE;`?

### Gabarito comentado

1. Use `SET estoque = estoque + 10` e filtre com `WHERE sku = 'SKU-CAN-001'`.
2. Separe as atribuições por vírgula dentro de `SET`; `RETURNING` pode listar `preco` e `estoque`.
3. Sem `WHERE`, todos os produtos serão desativados.
