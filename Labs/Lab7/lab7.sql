-- Functions follow the computer-sciency definition in that they
-- MUST return a value and cannot alter the data they receive as
-- parameters (the arguments). Functions are not allowed to
-- change anything, must have at least one parameter, and they
-- must return a value. Stored procs do not have to have a
-- parameter, can change database objects, and do not have to
-- return a value.
--1
delimiter $$

create function absolute_balance(c_name varchar(255))
  returns float
  begin
  declare s_b, s_a integer;
  select sum(balance) into s_b
  from account natural join depositor
  where customer_name = c_name;
  select sum(amount) into s_a
  from loan natural join borrower
  where customer_name = c_name;
  return s_b - s_a;
  end$$

delimiter ;

delimiter $$

create function absolute_balance2(c_name varchar(255))
  returns float
  begin
  declare s_b float;
  select (sum(balance)-sum(amount)) into s_b
  from account natural join depositor,loan natural join borrower
  where borrower.customer_name = c_name
  and depositor.customer_name = c_name;
  return s_b;
  end$$

delimiter ;

delimiter $$

create function absolute_balance3(c_name varchar(255))
  returns float
  begin
  declare s_b integer default 0;
  declare s_a integer default 0;
  select sum(balance) into s_b
  from account natural join depositor
  where customer_name = c_name;
  select sum(amount) into s_a
  from loan natural join borrower
  where customer_name = c_name;
  return s_b - s_a;
  end$$

delimiter ;
--2
--3
 select c.customer_name
 from customer as c
 where absolute_balance(c.customer_name)>=all(
   select absolute_balance(customer_name)
   from customer);
--Jones

--4
delimiter $$

create procedure list(in branch varchar(255))
  begin
  select distinct d.customer_name
  from depositor d, account aaf
  where a.account_number =d.account_number
  and a.branch_name = branch;
  end$$

delimiter ;
 --6
 delimiter $$

create trigger check_amount before update on loan
  for each row
  begin
  if new.amount<0 then
   insert into account
   values(new.loan_number, new.branch_name, (-1)*new.amount);
   insert into depositor(
      select customer_name, loan_number
      from borrower b
      where b.loan_number = new.loan_number);
      set new.amount =0;
  end if;
end$$

 delimiter ;

 --7 ok
