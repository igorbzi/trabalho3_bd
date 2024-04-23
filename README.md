# Como executar os scripts
Para rodar os scripts, siga a seguinte ordem:

 1. No bash do linux, execute os comandos escritos no arquivo pastas.txt;
 2. Após a criação das pastas, conecte no psql;
 3. Execute as 8 primeiras linhas do script1.sql, e depois execute as linhas restantes;
 4. Insira a senha para o usuário1: senha1;
 5. Execute o arquivo tables.sql;
 6. Execute o arquivo function.sql;
 7. Execute o arquivo script2.sql.

## Senhas
* usuario1: senha1
* usuario2: senha2

## Permissões
O usuario1 é dono do db01 e por isso tem todas as permissões para as tabelas e funções do esquema1.

O usuario2 tem permissão de select nas tabelas product e sale, e todos os privilégios na tabela sale_item.
Para poder realizar mudanças na tabela sale_item, devido a trigger de auditoria, o usuario2 também tem permissão para inserção na tabela log_sale_item.