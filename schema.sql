select pg_terminate_backend(pid)
from pg_stat_activity
where datname='tickets_viewer_app'
and pid!=pg_backend_pid();

drop database tickets_viewer_app;

create database tickets_viewer_app;

\c tickets_viewer_app;

create table users(
  id                serial primary key,
  account_name      text,
  email             varchar(500),
  password_digest   varchar(500)
);