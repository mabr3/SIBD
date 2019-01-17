delimiter $$

create procedure change_val()
  begin
  update produced_indicator p
    set p.value = 0.1*p.value,
    p.name = p.name,
    p.VAT_owner = p.VAT_owner,
    p.date_timestamp = p.date_timestamp,
    p.num = p.num,
    p.indicator_name = p.indicator_name
    where p.indicator_name in(
      select indicator.name
      from indicator
      where indicator.units = 'milligrams');

  update indicator i
    set i.units = 'centigrams',
    i.reference_value = 0.1*i.reference_value
    where i.units= 'milligrams';
  end $$

delimiter ;
