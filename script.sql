create tablespace tbspc01 location '/tablespc/tbspc01';
create tablespace tbspc02 location '/tablespc/tbspc02';

create user usuario1 password 'senha1';
create user usuario2 password 'senha2';

create schema esquema1;

alter user usuario1 set search_path to esquema1;

create database db01 tablespace tbspc01;
alter database db01 set search_path = esquema1;

alter database db01 owner to usuario1;
grant usage on schema esquema1 to usuario1;
\c db01;