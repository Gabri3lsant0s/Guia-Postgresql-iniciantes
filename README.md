# Guia PostgreSQL para Iniciantes

Projeto pessoal para praticar SQL com PostgreSQL e registrar minha evolução nos estudos.

## Como executar

1. Instale o PostgreSQL e abra o terminal na pasta do projeto.
2. Conecte-se ao banco `postgres`:

   `psql -U postgres -d postgres`

3. Crie o banco de estudos:

   ```sql
   -- Cria um banco exclusivo para os exercícios do guia.
   CREATE DATABASE guia_postgresql;
   ```

4. Conecte-se ao banco criado:

   `psql -U postgres -d guia_postgresql`

5. Execute o script do capítulo desejado. Exemplo para o Capítulo 2:

   `psql -U postgres -d guia_postgresql -f sql/02_tipos_de_dados.sql`

   Ou abra o arquivo `.sql` no Query Tool do pgAdmin e execute o conteúdo.

> Leia os comentários e tente prever o resultado antes de executar cada comando. Use este banco apenas para estudo.

## Conteúdos estudados

- Capítulo 1: primeira consulta e conceitos do PostgreSQL
- Capítulo 2: tipos numéricos, texto, datas, Identity, UUID e JSONB
- Capítulo 3: criação de tabelas
- Capítulo 4: alteração e remoção de estruturas
- Capítulo 5: inserção de dados
- Capítulo 6: remoção de dados
- Capítulo 7: atualização de dados
- Capítulo 8: consulta e seleção de dados

## Estrutura do projeto

```text
guia-postgresql-iniciantes/
├── README.md
├── capitulos/
│   ├── 01-introducao.md
│   ├── 02-tipos-de-dados.md    
│   └── 03-criacao-de-dados.md
└── sql/
     ├── 01_primeiros_passos.sql
     ├── 02_tipos_de_dados.sql
     └── 03_criacao_de_tabelas.sql
```

## Autor

Gabriel — estudante de PostgreSQL.
