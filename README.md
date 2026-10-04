#<p align="center">
  <img src="assets/banner-trilha.svg" alt="Trilha do Guia PostgreSQL para Iniciantes com os 8 capítulos" width="100%">
</p>

<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postgresql/postgresql-original.svg" alt="Logo do PostgreSQL" width="90" height="90">
  &nbsp;&nbsp;&nbsp;
  <img src="https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white" alt="Selo SQL">
</p>

<h1 align="center">Guia PostgreSQL para Iniciantes</h1>

<p align="center">
  Projeto pessoal para praticar SQL com PostgreSQL e registrar minha evolução nos estudos.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=databricks&logoColor=white" alt="SQL">
  <img src="https://img.shields.io/badge/pgAdmin-336791?style=for-the-badge&logo=postgresql&logoColor=white" alt="pgAdmin">
  <img src="https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white" alt="Markdown">
  <img src="https://img.shields.io/badge/Status-em%20estudo-F2A900?style=for-the-badge" alt="Status: em estudo">
</p>

---

## 🗺️ Sumário

- [Trilha de estudos](#️-trilha-de-estudos)
- [Instalando o PostgreSQL](#-instalando-o-postgresql)
- [Como executar](#️-como-executar)
- [Conteúdos estudados](#-conteúdos-estudados)
- [Estrutura do projeto](#-estrutura-do-projeto)
- [Tecnologias](#️-tecnologias)
- [Autor](#-autor)

---

## 🎮 Trilha de estudos

Cada capítulo é uma fase: leia o texto em `capitulos/` e rode o script correspondente em `sql/`.

| Fase | Capítulo | Comando principal | Texto | Script |
|:---:|---|---|---|---|
| 1 | Introdução | `SELECT 1;` | [01-introducao.md](capitulos/01-introducao.md) | [01_primeiros_passos.sql](sql/01_primeiros_passos.sql) |
| 2 | Tipos de dados | `JSONB` · `UUID` · `IDENTITY` | [02-tipos-de-dados.md](capitulos/02-tipos-de-dados.md) | [02_tipos_de_dados.sql](sql/02_tipos_de_dados.sql) |
| 3 | Criação de tabelas | `CREATE TABLE` | [03-criacao-de-tabelas.md](capitulos/03-criacao-de-tabelas.md) | [03_criacao_de_tabelas.sql](sql/03_criacao_de_tabelas.sql) |
| 4 | Alteração de tabelas | `ALTER` · `DROP` | [04-alteracao-de-tabelas.md](capitulos/04-alteracao-de-tabelas.md) | [04_alteracao_de_tabelas.sql](sql/04_alteracao_de_tabelas.sql) |
| 5 | Inserção de dados | `INSERT INTO` | [05-insercao-de-dados.md](capitulos/05-insercao-de-dados.md) | [05_insercao_de_dados.sql](sql/05_insercao_de_dados.sql) |
| 6 | Remoção de dados | `DELETE` | [06-remocao-de-dados.md](capitulos/06-remocao-de-dados.md) | [06_remocao_de_dados.sql](sql/06_remocao_de_dados.sql) |
| 7 | Atualização de dados | `UPDATE` | [07-atualizacao-de-dados.md](capitulos/07-atualizacao-de-dados.md) | [07_atualizacao_de_dados.sql](sql/07_atualizacao_de_dados.sql) |
| 8 | Consulta de dados | `SELECT` | [08-consulta-de-dados.md](capitulos/08-consulta-de-dados.md) | [08_consulta_de_dados.sql](sql/08_consulta_de_dados.sql) |

---

## 📥 Instalando o PostgreSQL

Escolha o seu sistema operacional. Todos os caminhos levam ao mesmo resultado: o servidor PostgreSQL rodando na porta `5432` e o terminal `psql` funcionando.

> [!TIP]
> Use a versão estável mais recente (**PostgreSQL 18** na data desta revisão). Evite versões **beta** (como a 19) para estudar. As páginas oficiais de download são sempre a fonte mais atual: [postgresql.org/download](https://www.postgresql.org/download/).

<details>
<summary><b>🪟 Windows</b></summary>

1. Acesse [postgresql.org/download/windows](https://www.postgresql.org/download/windows/) e baixe o instalador da EDB (**Download the installer**), escolhendo a versão 18 para a sua arquitetura (64 bits na grande maioria dos computadores).
2. Execute o instalador e avance mantendo marcados os componentes:
   - **PostgreSQL Server**
   - **pgAdmin 4** (interface gráfica)
   - **Command Line Tools** (traz o `psql`)
3. Defina uma **senha para o usuário `postgres`** e anote em um lugar seguro. Você vai precisar dela a cada conexão.
4. Mantenha a **porta 5432** e o *locale* padrão, a menos que tenha um motivo para mudar.
5. Ao terminar, procure no Menu Iniciar por **SQL Shell (psql)** ou **pgAdmin 4** para testar.

Para usar o `psql` em qualquer terminal (PowerShell ou CMD), adicione a pasta `bin` ao PATH do Windows:

```text
C:\Program Files\PostgreSQL\18\bin
```

Feche e abra o terminal e confira:

```powershell
psql --version
```

</details>

<details>
<summary><b>🍎 macOS</b></summary>

**Opção A: Postgres.app (mais simples, com interface)**

1. Baixe em [postgresapp.com](https://postgresapp.com/) e arraste o app para a pasta **Aplicativos**.
2. Abra o app e clique em **Initialize** para criar o servidor.
3. Para usar o `psql` no Terminal, execute uma vez (ajuste o número da versão se for diferente):

   ```bash
   sudo mkdir -p /etc/paths.d &&
   echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp
   ```

**Opção B: Homebrew**

```bash
brew install postgresql@18
brew services start postgresql@18
```

Se o comando `psql` não for encontrado, o próprio Homebrew mostra no fim da instalação a linha para adicionar ao PATH (algo como `echo 'export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"' >> ~/.zshrc`).

> [!IMPORTANT]
> No macOS, o superusuário inicial costuma ser o **seu usuário do Mac**, e não `postgres`. Se `psql -U postgres` der erro, conecte com `psql postgres` e crie o papel, se quiser seguir o guia exatamente:
>
> ```sql
> CREATE ROLE postgres WITH SUPERUSER LOGIN;
> ```

</details>

<details>
<summary><b>🐧 Linux: Ubuntu e Debian</b></summary>

**Forma rápida** (instala a versão disponível na sua distribuição):

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

**Versão mais nova** (repositório oficial PGDG):

```bash
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
sudo apt install -y postgresql-18
```

Confirme que o serviço está ativo:

```bash
sudo systemctl status postgresql
```

No Linux, o usuário `postgres` do sistema é o dono do banco. Para abrir o `psql`:

```bash
sudo -u postgres psql
```

Para definir uma senha para o usuário `postgres` do banco (útil para conectar por `-U postgres`):

```sql
ALTER USER postgres PASSWORD 'sua_senha_aqui';
```

</details>

<details>
<summary><b>🐧 Linux: Fedora, RHEL, CentOS, Rocky e AlmaLinux</b></summary>

```bash
sudo dnf install postgresql-server postgresql-contrib
sudo postgresql-setup --initdb
sudo systemctl enable --now postgresql
```

Para a versão mais recente, use o assistente do repositório oficial em [postgresql.org/download/linux/redhat](https://www.postgresql.org/download/linux/redhat/), que gera os comandos certos para a sua distribuição e versão.

Para abrir o `psql`:

```bash
sudo -u postgres psql
```

</details>

<details>
<summary><b>🐧 Linux: Arch e Manjaro</b></summary>

```bash
sudo pacman -S postgresql
sudo -iu postgres initdb --locale=C.UTF-8 --encoding=UTF8 -D /var/lib/postgres/data
sudo systemctl enable --now postgresql
sudo -u postgres psql
```

</details>

<details>
<summary><b>🐳 Qualquer sistema com Docker (alternativa)</b></summary>

Ótimo para estudar sem instalar nada no computador e apagar tudo depois:

```bash
docker run --name postgres-estudo -e POSTGRES_PASSWORD=sua_senha_aqui -p 5432:5432 -d postgres:18
```

Entrar no `psql` dentro do contêiner:

```bash
docker exec -it postgres-estudo psql -U postgres
```

Parar e remover quando quiser:

```bash
docker stop postgres-estudo && docker rm postgres-estudo
```

</details>

### ✅ Conferindo se deu certo

```bash
psql --version
```

Deve aparecer algo como `psql (PostgreSQL) 18.x`. Depois, teste a conexão com o servidor:

```bash
psql -U postgres -h localhost -c "SELECT version();"
```

### 🔧 Problemas comuns

| Sintoma | Causa provável | O que fazer |
|---|---|---|
| `psql` não é reconhecido | A pasta `bin` não está no PATH | Adicione-a ao PATH (veja o seu sistema acima) e reabra o terminal |
| `password authentication failed` | Senha errada | Use a senha definida na instalação; no Linux, defina uma com `ALTER USER` |
| `Peer authentication failed` (Linux) | O Linux tenta usar o seu usuário do sistema | Use `sudo -u postgres psql` ou conecte com `-h localhost` |
| `role "postgres" does not exist` (macOS) | O superusuário é o seu usuário do Mac | Use `psql postgres` ou crie o papel (veja o macOS acima) |
| `connection refused` | O servidor não está rodando | Inicie o serviço (`systemctl`, `brew services` ou abra o Postgres.app) |
| Porta 5432 em uso | Outra instalação do PostgreSQL já está ativa | Pare a outra instância ou escolha outra porta na instalação |

> [!NOTE]
> Se você já tem outra versão do PostgreSQL instalada, o instalador pode sugerir a porta `5432` ocupada e escolher `5433`. Nesse caso, adicione `-p 5433` aos comandos do `psql`.

---

## ▶️ Como executar

1. Instale o PostgreSQL (veja a seção acima) e abra o terminal na pasta do projeto.
2. Conecte-se ao banco `postgres`:

   ```bash
   psql -U postgres -d postgres
   ```

3. Crie o banco de estudos:

   ```sql
   -- Cria um banco exclusivo para os exercícios do guia.
   CREATE DATABASE guia_postgresql;
   ```

4. Conecte-se ao banco criado:

   ```bash
   psql -U postgres -d guia_postgresql
   ```

5. Execute os scripts SQL em ordem, um por vez, acompanhando o capítulo correspondente. Exemplo:

   ```bash
   psql -U postgres -d guia_postgresql -f sql/03_criacao_de_tabelas.sql
   ```

   Ou abra o arquivo `.sql` no **Query Tool** do pgAdmin e execute o conteúdo.

> [!IMPORTANT]
> Os capítulos 3 a 8 dependem das estruturas e dos dados criados antes. Leia os comentários, execute os scripts na ordem e não repita scripts que criam ou alteram estruturas sem entender o efeito.

> [!WARNING]
> Use este banco apenas para estudo.

---

## 📚 Conteúdos estudados

- [x] **Capítulo 1:** primeira consulta e conceitos do PostgreSQL
- [x] **Capítulo 2:** tipos numéricos, texto, datas, Identity, UUID e JSONB
- [x] **Capítulo 3:** criação de tabelas
- [x] **Capítulo 4:** alteração e remoção de estruturas
- [x] **Capítulo 5:** inserção de dados
- [x] **Capítulo 6:** remoção de dados
- [x] **Capítulo 7:** atualização de dados
- [x] **Capítulo 8:** consulta e seleção de dados

---

## 📁 Estrutura do projeto

```text
guia-postgresql-iniciantes/
├── README.md
├── assets/
│   └── banner-trilha.svg
├── capitulos/
│   ├── 01-introducao.md
│   ├── 02-tipos-de-dados.md
│   ├── 03-criacao-de-tabelas.md
│   ├── 04-alteracao-de-tabelas.md
│   ├── 05-insercao-de-dados.md
│   ├── 06-remocao-de-dados.md
│   ├── 07-atualizacao-de-dados.md
│   └── 08-consulta-de-dados.md
└── sql/
    ├── 01_primeiros_passos.sql
    ├── 02_tipos_de_dados.sql
    ├── 03_criacao_de_tabelas.sql
    ├── 04_alteracao_de_tabelas.sql
    ├── 05_insercao_de_dados.sql
    ├── 06_remocao_de_dados.sql
    ├── 07_atualizacao_de_dados.sql
    └── 08_consulta_de_dados.sql
```

---

## 🛠️ Tecnologias

<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postgresql/postgresql-original.svg" alt="PostgreSQL" width="48" height="48">
  &nbsp;
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg" alt="Git" width="48" height="48">
  &nbsp;
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" alt="GitHub" width="48" height="48">
  &nbsp;
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg" alt="VS Code" width="48" height="48">
</p>

---

## 👨‍💻 Autor

**Gabriel** — estudante de PostgreSQL.
