create view dim_date as
  select distinct date_timestamp, year(date_timestamp) as year, month(date_timestamp) as month, day(date_timestamp) as day
  from consult;

create view dim_animal as
  select name ,VAT,species_name, age
  from animal;


create view facts_consults as select d2.name, d2.vat, d1.date_timestamp,
  (select count(*)
  from _procedure as p
  where d2.name = p.name
  and d2.vat = p.VAT_owner
  and d1.date_timestamp = p.date_timestamp
  group by p.name, p.VAT_owner, p.date_timestamp) as nr_procedures,
  (select count(*)
  from prescription as p
  where d2.name = p.name
  and d2.vat = p.VAT_owner
  and d1.date_timestamp = p.date_timestamp
  group by p.name, p.VAT_owner, p.date_timestamp) as nr_medications
  from dim_animal as d2, dim_date as d1, consult c
  where d2.name = c.name
  and c.VAT_owner = d2.vat
  and c.date_timestamp = d1.date_timestamp
  group by c.name, c.VAT_owner, c.date_timestamp;
