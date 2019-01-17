delimiter $$

create function count_consults(a_name varchar(255), a_VAT varchar(25), y integer)
 returns integer
 begin
 declare total integer;
 select count(*) into total
 from consult c
 where c.name = a_name
 and c.VAT_owner = a_VAT
 and year(c.date_timestamp) = y;
 return total;
end$$

delimiter ;
