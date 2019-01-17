-- ex1
select distinct customer_name
from account,depositor
where balance >500
  AND account.account_number = depositor.account_number;

-- ex2
select distinct customer_city
from loan,borrower,customer
where amount >1000
and amount <2000
AND borrower.customer_name = customer.customer_name
AND borrower.loan_number=loan.loan_number;

-- ex3
select balance*0.99
from account
where branch_name = 'Perryridge';

-- ex4
sselect account.account_number, balance
from account, depositor, borrower
where borrower.loan_number = 'L-15'
and borrower.customer_name = depositor.customer_name 
and account.account_number = depositor.account_number;

-- ex5
select distinct customer_name
from customer,branch
where customer.customer_city = branch.branch_city;

-- ex6
select branch.branch_name, assets
from branch,account,depositor
where depositor.customer_name = 'Jones'
and depositor.account_number = account.account_number
and account.branch_name = branch.branch_name;

-- ex7
select distinct depositor.customer_name, account.branch_name
from account,depositor
where depositor.customer_name like 'J%s'
and depositor.account_number = account.account_number;

-- ex8
select borrower.customer_name,customer.customer_street, loan.loan_number, loan.amount
from borrower,loan,customer
where borrower.loan_number=loan.loan_number
and borrower.customer_name=customer.customer_name
and customer.customer_street like '____';

-- ex9
select borrower.customer_name
from borrower,depositor,account,loan
where borrower.customer_name = depositor.customer_name
and borrower.loan_number = loan.loan_number
and depositor.account_number = account.account_number
and loan.branch_name = account.branch_name;
