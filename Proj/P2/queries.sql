--1

select c.name as animal_name, p.name as owner_name, a.species_name, a.age
from consult c, animal a, person p
where p.VAT = c.VAT_owner
and a.VAT = p.VAT
and a.name =c.name
and c.VAT_vet in(
  select VAT
  from person
  where person.name = 'John Smith')
  group by c.name, p.name;

--2

select i.name, i.reference_value
from indicator i
where i.units = 'milligrams'
and i.reference_value >100
order by i.reference_value desc;

--3
select a.name as animal_name, p.name as person_name, a.species_name, a.age
from animal a, person p
where p.VAT =a.VAT
and exists(
  select c.name, c.VAT_owner
  from consult c
  where c.o
  like '%obese%'
  and c.name = a.name
  and c.VAT_owner = a.VAT
  union
  select c2.name, c2.VAT_owner
  from consult c2
  where c2.o
  like '%obesity%'
  and c2.name = a.name
  and c2.VAT_owner=a.VAT)
and exists(
  select weight
  from consult c3
  where c3.weight >30
  and c3.name =a.name
  and c3.VAT_owner = a.VAT
  and c3.date_timestamp >=all(
    select date_timestamp
    from consult c4
    where c3.name =c4.name
    and c3.VAT_owner=c4.VAT_owner));

--4

select p.name, p.VAT, p.address_street, p.address_city
from person p
where p.VAT in (
  select VAT
  from client)
and p.VAT not in (
  select a.VAT
  from animal a);

--5

select p.code, dc.name, count( distinct p.name_med, p.dosage,p.lab) as count
from prescription p, diagnosis_code dc
where dc.code=p.code
group by dc.code
order by count asc;



--6
select NA.a/NC.c as avg_assistants, NP.p/NC.c as avg_procedures, ND.d/NC.c as avg_diagnosis, NPP.p/NC.c as avg_aprescriptions
from
(select count(*) as c from consult where year(date_timestamp)=2017) as NC,
(select count(*) as a from participation where year(date_timestamp)=2017) as NA,
(select count(*) as p from _procedure where year(date_timestamp)=2017) as NP,
(select count(*) as d from consult_diagnosis where year(date_timestamp)=2017) as ND,
(select count(*) as p from prescription where year(date_timestamp)=2017) as NPP;

--7


    select a.species_name, cd.code, dc.name
    from consult_diagnosis cd inner join animal a
    on cd.name = a.name and cd.VAT_owner = a.VAT,
    diagnosis_code dc
    where a.species_name in (
      select gs.name1
      from generalization_species gs
      where gs.name2= 'dog')
    and dc.code = cd.code
    group by a.species_name
    order by count(*) desc;

--8

select p.name
from person p, client c
where p.VAT = c.VAT
and c.VAT in(
   select VAT
   from veterinary
   union
   select VAT
   from assistant);

--9

  select distinct p.name, p.address_street, p.address_city
  from person p, client inner join animal
    on client.VAT = animal.VAT
  where animal.VAT not in (
     select VAT
     from animal
     where species_name not like '%bird%')
  and p.VAT =client.VAT;
