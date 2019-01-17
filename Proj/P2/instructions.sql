--1
update person
set address_street = 'New JSmith client street'
where person.name = 'John Smith'
and person.VAT in(select VAT from client);

--2
update indicator i
set i.reference_value = i.reference_value * 1.1
where i.name in (
  select distinct produced_indicator.indicator_name
  from produced_indicator, test_procedure
  where test_procedure.num = produced_indicator.num
  and test_procedure.type='blood');

--3

delete from person
where name ='John Smith'
and person.VAT in(
  select VAT
  from client);

--4

  insert into diagnosis_code(code,name)
    values('C-150','end_stage renal disease');
update consult_diagnosis cd
set cd.code = 'C-150',
  cd.name=cd.name,
  cd.VAT_owner =cd.VAT_owner,
  cd.date_timestamp = cd.date_timestamp
  where cd.code = 'C-02'
  and (cd.name, cd.VAT_owner, cd.date_timestamp) in(
    select p.name, p.VAT_owner, p.date_timestamp
    from produced_indicator p
    where p.indicator_name = 'creatinine level'
    and p.value > 1.0
  );
