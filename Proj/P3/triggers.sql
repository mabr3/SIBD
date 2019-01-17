--1
delimiter $$
create trigger act_age after insert on consult
for each row
begin
  update animal
    set age = year(new.date_timestamp) - birth_year
    where animal.VAT = new.VAT_owner
    and  animal.name = new.name;
end$$

delimiter ;

--2

delimiter $$

create trigger check_vet before insert on assistant
 for each row
 begin
 if exists (select * from veterinary v where v.VAT =new.VAT) then
   signal sqlstate '45000'
   set message_text = "There's already a veterinary with that VAT.";
 end if;
end $$

delimiter ;

delimiter $$

create trigger check_vet2 before update on assistant
 for each row
 begin
 if exists (select * from veterinary v where v.VAT =new.VAT) then
   signal sqlstate '45000'
   set message_text = "There's already a veterinary with that VAT.";
 end if;
end $$

delimiter ;

delimiter $$

create trigger check_assist before insert on veterinary
 for each row
 begin
 if exists (select * from assistant a where a.VAT =new.VAT) then
   signal sqlstate '45000'
   set message_text = "There's already an assistant with that VAT.";
  end if;
end $$

delimiter ;

delimiter $$

create trigger check_assist2 before update on veterinary
 for each row
 begin
 if exists (select * from assistant a where a.VAT =new.VAT) then
   signal sqlstate '45000'
   set message_text = "There's already an assistant with that VAT.";
  end if;
end $$

delimiter ;

--3
delimiter $$

create trigger check_indiv before insert on phone_number
 for each row
 begin
 if exists(select * from phone_number pn where new.phone = pn.phone) then
   signal sqlstate '45000'
   set message_text = "That phone number is already associated with another individual.";
 end if;
end$$

delimiter ;

delimiter $$

create trigger check_indiv2 before update on phone_number
 for each row
 begin
 if exists(select * from phone_number pn where new.phone = pn.phone) then
   signal sqlstate '45000'
   set message_text = "That phone number is already associated with another individual.";
 end if;
end$$

delimiter ;
