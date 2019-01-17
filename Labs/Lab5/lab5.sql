--ex1
select customer.customer_name, branch.branch_name, branch.branch_city, loan.loan_number
from customer, borrower, loan, branch
where customer.customer_city = branch.branch_city
and borrower.customer_name = customer.customer_name
and borrower.loan_number = loan.loan_number
and branch.branch_name = loan.branch_name;
--este mostra qual é. queremos é contar

select count(distinct b.customer_name)
from borrower b, customer c, loan l, branch B
where b.customer_name = c.customer_name
and l.loan_number = b.loan_number
and l.branch_name = B.branch_name
and B.branch_city = c.customer_city;

--ex2
select d.customer_name, avg(balance)
from depositor d, account a
where d.account_number = a.account_number
group by d.customer_name;

--ex3
select d.customer_name, avg(balance)
from depositor as d, branch as b, account as a
where b.branch_city = 'Horseneck'
and b.branch_name = a.branch_name
and a.account_number = d.account_number
group by d.customer_name;

--ex4
select sum(balance)
from branch as b, account as a
where a.branch_name =b.branch_name
and b.branch_city = 'Horseneck';

--ex5
select b.branch_city, sum(balance)
from branch b, account a
where b.branch_name = a.branch_name
group by b.branch_city;

--ex6
select l.branch_name
from loan l
group by l.branch_name
having count(l.branch_name)>=2;

--ex7
select l.branch_name, sum(l.amount)
from loan l
group by l.branch_name
having count(l.branch_name)>=2;

--ex8
select b.branch_name, b.branch_city
from branch b left outer join account a
on b.branch_name = a.branch_name
where a.branch_name is null;

--ex9
select distinct c.customer_name
from customer c
where c.customer_name
not in (select customer_name from depositor);

--ex10

select branch_name
from branch
where branch_name
not in (
  select branch_name
  from account
  union
  select branch_name
  from loan);
  -- porque é que com parêntesis
  -- na union não dava?
  -- not in (()union())

--ex11

select branch_name
from branch
where branch_name
not in (
  select account.branch_name
  from account,loan
  where loan.branch_name = account.branch_name);

--ex12

select distinct c.customer_name, c.customer_city
from customer c
where c.customer_city
in (
  select branch_city
  from branch);

--ex13

select l.loan_number, l.amount
from loan l
where l.amount >=all (
  select amount
  from loan);

--ex14

select b.customer_name, sum(l.amount)
from loan l, borrower b
where b.loan_number = l.loan_number
group by b.customer_name;

--ex15
select b.customer_name
from borrower b, loan l
where l.loan_number = b.loan_number
and l.amount >=all (
 select amount
 from loan);
