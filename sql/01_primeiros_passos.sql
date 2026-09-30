-- Passo 1: sua primeira consulta PostgreSQL
-- Leia o comentário e tente prever o resultado antes de executar.

-- SELECT pede ao PostegreSQL que devolva o resultado. 
-- O texto entre aspas é um valor; AS dá i,nome à coluna exibida.
SELECT 'Olá, PostgreSQL!' AS mensagem;

-- CURRENT_DATE retorna a data atual conhecida pelo servidor.
-- Execute esta consulta e compare o resultado com a data de hoje.
SELECT CURRENT_DATE AS data_de_hoje;

-- DESAFIO: troque a frase por seu nome ou uma mensagem novamente.
-- Mantenha o nome da coluna como saudacao e execute novamente.
SELECT 'Gabriel' AS saudacao;