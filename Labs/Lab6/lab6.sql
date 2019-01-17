--ex1
select b.branch_name
from branch b
where b.branch_city = 'Brooklyn';

--ex2
select b.branch_name, a.account_number
from branch b, account a
where b.branch_city = 'Brooklyn'
and b.branch_name = a.branch_name;

--ex3
select b.branch_name, a.account_number, d.customer_name
from branch b, account a, depositor d
where b.branch_city = 'Brooklyn'
and b.branch_name = a.branch_name
and a.account_number = d.account_number;

--ex4

--Johnson. Mas como fazer o query?

select d.customer_name
from branch b, account a, depositor d
where b.branch_city = 'Brooklyn'
and b.branch_name = a.branch_name
and a.account_number = d.account_number
having count(distinct b.branch_name) = any (
  select count(customer_name)
  from depositor
  group by customer_name);

--ex5

select distinct customer_name --queremos costuemr name
from depositor as d -- de depositor
where not exists ( -- onde não exista
  select branch_name -- um branch
  from branch as b
  where branch_city = 'Brooklyn' --de brooklyn
  and branch_name not in ( -- cujo nome não esteja
    select branch_name
    from account as a, depositor as d2 --associado a alguma cont
    where a.account_number = d2.account_number
    and d2.customer_name = d.customer_name));

--ex6

Procura um costumer name, para o qual não exista um branch de Brooklyn que não esteja
associado a ele! i.e.: para todos os customer_names, vê todos os brnahces de brooklyn e vê
se existe algum branch de Brooklyn para o qual este cliente não tenha conta. Johnson tem conta
para ambos os branches.

ultimo select são todas as contas associadas aos depositors. select do meio seleciona todos
os branches de brooklyn e assim vê as pessoas que não têm conta em todos os branches.
Depois, nega essa lista toda, sobrando apenas a pessoa que tem conta em ambos os branches!

Basicamente faz uma lsita de pessoas que não tem conta nos dois branches. e nega isso.

--ex7
select distinct customer_name
from depositor as d
where not exists (
  select branch_name
  from branch as b
  where branch_city = 'Brooklyn'
  and not exists (
    select branch_name
    from account as a, depositor as d2
    where a.account_number = d2.account_number
    and d2.customer_name = d.customer_name
    and b.branch_name = a.branch_name));

--ex8
select distinct d.customer_name
from depositor d, customer c
where d.customer_name = c.customer_name
and not exists(
  select branch_name
  from branch b
  where b.branch_city = c.customer_city
  and branch_name not in(
     select branch_name
     from account a, depositor d2
     where a.account_number = d2.account_number
     and d.customer_name = d2.customer_name));

--ex9

select distinct d.customer_name
  from depositor as d left outer join customer c
    on d.customer_name = c.customer_name
  where not exists (
    select branch_name
    from branch as b
    where b.branch_city = c.customer_city
    and branch_name not in (
     select branch_name
     from account as a, depositor as d2
     where a.account_number = d2.account_number
     and d2.customer_name = d.customer_name));

--ex10
Como há cidades com 0 branches, e há customers com
0 accounts, selecciona essses!
--ex11
select distinct d.customer_name
from depositor as d left outer join customer c
  on d.customer_name = c.customer_name
where exists(
  select b2.branch_name
  from branch b2
  where b2.branch_city = c.customer_city)
and not exists (
  select branch_name
  from branch as b
  where b.branch_city = c.customer_city
  and branch_name not in (
    select branch_name
    from account as a, depositor as d2
    where a.account_number = d2.account_number
    and d2.customer_name = d.customer_name));

--ex12
create table movie (
  title varchar(255),
  year year,
  length time,
  primary key(title, year) );
create table ticket (
  number integer,
  showdate date,
  showtime time,
  title varchar(255),
  year year,
  primary key(number),
  foreign key(title, year) references movie(title, year) );

--ex13
insert into movie values ('Back to the Future', 1985, '01:56:00');
insert into movie values ('Back to the Future II', 1989, '01:48:00');
insert into movie values ('Back to the Future III', 1990, '01:58:00');
insert into ticket values (123456, '2016-11-12', '18:25:00', 'Back to the Future', 1985);
insert into ticket values (123457, '2016-11-12', '21:15:00', 'Back to the Future', 1985);
insert into ticket values (123458, '2016-11-13', '00:05:00', 'Back to the Future', 1985);
--ex14
select showdate, showtime,
  datediff(showdate, current_date) as daysuntil,
  timediff(showtime, current_time) as timeuntil
from ticket;
--ex15

select t.title, t.showtime as begins,
  addtime(addtime(t.showtime, m.length), sec_to_time(20*60)) as ends
from ticket as t, movie as m
where t.title = m.title and t.year = m.year;

--ex16
https://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html

--a)--

--b)--

--c)--

--d) com primary keys é mais rápido, identifica logo i guess. São indexadas
--   de forma a otimizar a pesquisa.

--e) re-indexar demora tempo? idk.

--f)
SELECT account_number FROM account WHERE balance = 1000;
SELECT MAX(balance) FROM account;
--ambos 0.05s

--g)

CREATE INDEX balance_idx ON account (balance);
-- é um índice secundário pois pode ter duplicados. (2 accs com o mesmo balance)

--h)
0.0 segundos agora. Como estão indexadas, a pesquisa é mais eficiente!

--i)
a- index on age
b- index on name
c- index on salary
d- index on age
