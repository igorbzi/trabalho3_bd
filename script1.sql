create tablespace tbspc01 location '/tablespc/tbspc01';
create tablespace tbspc02 location '/tablespc/tbspc02';

create user usuario1 password 'senha1';
create user usuario2 password 'senha2';

create database db01 tablespace tbspc01;
\c db01;

create schema esquema1 authorization usuario1;
alter user usuario1 set search_path to esquema1;

alter database db01 owner to usuario1;
alter database db01 set search_path = esquema1;
grant all on database db01 to usuario1 with grant option;
\c db01 usuario1;
--apos rodar esse script, inserir a senha do usuario1