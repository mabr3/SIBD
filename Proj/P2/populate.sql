insert into person(VAT,name,address_street,address_city,address_zip)
values('12345','John Smith', 'Street1', 'City1','1234-123'),
  ('54321','John Smith', 'Street 150','Citty2','1212-211'),
  ('12346','Johana Smith', 'Street2', 'City2','1234-991'),
  ('11111','John Johnes', 'Street2', 'City2','1234-981'),
  ('10010','Peter Albert', 'Fish Street', 'Old City','1441-191'),
  ('10011','Albertina Peterson', 'Good Street', 'Old City','1440-300'),
  ('19999','Edna Jules','Old Street', 'New City','0101-101'),
  ('10101','Jack Potter', 'Big Street', 'New City','3332-223');

insert into phone_number(VAT,phone)
values('12345', '911231231'),
  ('12346', '555-702-222'),
  ('12346', '555-702-224'),
  ('11111', '959595958'),
  ('10010', '718080800'),
  ('10101','+351900099098');

insert into client(VAT)
values('12346'),
('10011'),
('54321'),
('19999'),
('11111');

insert into assistant(VAT)
values('10101'),
('10010');

insert into veterinary(VAT,specialization, bio)
values('12345','Bird ophthalmology','Single, nice, good with birds, bat with cats. Graduated one year ago.'),
('10011','Dog therapy','Experient doctor, graduated in 1994, 2 kids, 2 cats, 3 dogs, no husband.');

insert into species(name, description)
values('mammal','any vertebrate of the class Mammalia, having the body more or less covered with hair, nourishing the young with milk from the mammary glands, and, with the exception of the egg-laying monotremes, giving birth to live young.'),
('reptile', 'any cold-blooded vertebrate of the class Reptilia, comprising the turtles, snakes, lizards, crocodilians, amphisbaenians, tuatara, and various extinct members including the dinosaurs.'),
('bird',' any warm-blooded vertebrate of the class Aves, having a body covered with feathers, forelimbs modified into wings, scaly legs, a beak, and no teeth, and bearing young in a hard-shelled egg.'),
('fish','any of various cold-blooded, aquatic vertebrates, having gills, commonly fins, and typically an elongated body covered with scales.'),
('dog','any carnivore of the dog family Canidae, having prominent canine teeth and, in the wild state, a long and slender muzzle, a deep-chested muscular body, a bushy tail, and large, erect ears'),
('cat','any of several carnivores of the family Felidae, as the lion, tiger, leopard or jaguar, etc'),
('snake','any of numerous limbless, scaly, elongate reptiles of the suborder Serpentes, comprising venomous and nonvenomous species inhabiting tropical and temperate areas.'),
('goldfish','a small, usually yellow or orange fish, Carassius auratus, of the carp family, native to China, bred in many varieties and often kept in fishbowls and pools.'),
('redbird','a bird that is red'),
('husky', 'looks like a wolf'),
('labrador', 'fun dog'),
('bluebird','a bird that is blue'),
('betta fish',' elegant tropical freshwater fish wiht different birght colors that come to the surface often to suck air from outside the water.');

insert into generalization_species(name1,name2)
  values('dog', 'mammal'),
  ('cat','mammal'),
  ('snake','reptile'),
  ('goldfish','fish'),
  ('betta fish','fish'),
  ('bluebird','bird'),
  ('labrador', 'dog'),
  ('husky', 'dog'),
  ('redbird','bird');

insert into animal(name, VAT,species_name, colour, gender, birth_year, age)
  values('Quim','12346','bluebird','blue','male','2013','5'),
  ('Joa','12346','labrador','black','female','2015','3'),
  ('Mari','10011','cat','grey','female','2008','10'),
  ('Garfield','10011','cat','orange','male','2000','18'),
  ('Bella','19999','bluebird','blue','female','2012','6'),
  ('Joa','10011','husky','blackish','female','2016','2'),
  ('Ruca','54321','labrador','golden','male','2009','9'),
  ('Ed','19999','redbird','red','male','2015','3');

insert into consult(name,VAT_owner,date_timestamp,s,o,a,p,VAT_client, VAT_vet,weight)
  values('Quim','12346','2014-10-09 18:19:20','looks good', 'has wings','NULL','NULL','12346','12345','1.2'),
  ('Bella','19999','2013-11-11 11:11:11','NULL', 'NULL','NULL','treat her','19999','12345','1.1'),
  ('Joa','12346','2015-01-09 10:10:20','NULL','NULL','has food posioning','NULL','12346','10011','20.73'),
  ('Joa','12346','2017-01-09 10:10:20','NULL','getting obese','has food posioning','NULL','12346','12345','31'),
  ('Joa','10011','2017-01-01 09:10:20','NULL','NULL','NULL','NULL','10011','12345','15'),
  ('Garfield','10011','2001-03-03 10-03-30','NULL','too fat','NULL','NULL','10011','12345','32'),
  ('Garfield','10011','2002-03-03 10-03-30','NULL','in danger of obesity','NULL','NULL','12346','12345','29'),
  ('Ruca','54321','2010-04-11 10:03:21','NULL','NULL','NULL','NULL','54321','10011','25'),
  ('Ruca','54321','2012-04-11 10:03:21','NULL','NULL','NULL','NULL','54321','10011','28'),
  ('Ruca','54321','2017-04-11 10:03:21','NULL','NULL','NULL','NULL','54321','10011','35');


insert into indicator(name, reference_value, units, description)
  values('indicator1','75','milligrams',"Blood"),
  ('indicator2','101','milligrams', 'Water'),
  ('indicator3','200','milligrams', 'CH34HCNSH'),
  ('indicator4','20','millilitres', 'very useful'),
  ('creatinine level','1.0','milligrams', 'renal stuff');

insert into participation(name, VAT_owner, date_timestamp, VAT_assistant)
  values('Quim','12346','2014-10-09 18:19:20','10101'),
  ('Bella','19999','2013-11-11 11:11:11','10101'),
  ('Joa','12346','2017-01-09 10:10:20','10010');

insert into diagnosis_code(code,name)
  values('C-01','diabetes'),
  ('C-02','kidney failure'),
  ('C-03','depression'),
  ('C-14','amnesia'),
  ('C-35','parvovirus');

insert into consult_diagnosis(code, name, VAT_owner,date_timestamp)
  values('C-01','Ruca','54321','2010-04-11 10:03:21'),
  ('C-01','Joa','12346','2017-01-09 10:10:20'),
  ('C-14','Joa','10011','2017-01-01 09:10:20'),
  ('C-14','Ruca','54321','2017-04-11 10:03:21'),
  ('C-35','Ruca','54321','2017-04-11 10:03:21'),
  ('C-02','Ruca','54321','2017-04-11 10:03:21'),
  ('C-02','Bella','19999', '2013-11-11 11:11:11');

insert into medication(name,lab,dosage)
  values('med1','lab2','50mg'),
  ('med2','lab2','100mg'),
  ('med2','lab2','400mg'),
  ('med25','lab90','100mg'),
  ('med1','lab90','200mg'),
  ('med12','lab1','250mg'),
  ('med43','lab0','40mg');

insert into prescription(code,name,VAT_owner,date_timestamp,name_med,lab,dosage,regime)
  values('C-01','Ruca','54321','2010-04-11 10:03:21','med2','lab2','400mg', "1x day"),
  ('C-01','Ruca','54321','2010-04-11 10:03:21','med2','lab2','100mg', "1x day"),
  ('C-02','Ruca','54321','2017-04-11 10:03:21','med12','lab1','250mg', "10x day"),
  ('C-14','Ruca','54321','2017-04-11 10:03:21','med43','lab0','40mg','3x day'),
  ('C-02','Bella','19999', '2013-11-11 11:11:11','med12','lab1','250mg','1x day 1x night'),
  ('C-02','Bella','19999', '2013-11-11 11:11:11','med1','lab90','200mg','1x night'),
  ('C-02','Bella','19999', '2013-11-11 11:11:11','med2','lab2','400mg','1x day');

insert into _procedure(name, VAT_owner,date_timestamp,num,description)
  values('Ruca','54321',' 2012-04-11 10:03:21',150,'test'),
  ('Ruca','54321','2017-04-11 10:03:21',200,'test2'),
  ('Garfield','10011','2002-03-03 10-03-30',35,'testting'),
  ('Joa','12346','2017-01-09 10:10:20',450,'all good'),
  ('Joa','12346','2017-01-09 10:10:20',451, 'not so good');

insert into performed(name, VAT_owner,date_timestamp,num, VAT_assistant)
  values('Joa','12346','2017-01-09 10:10:20',451,'10101'),
  ('Joa','12346','2017-01-09 10:10:20',450,'10101'),
  ('Garfield','10011','2002-03-03 10-03-30',35,'10101'),
  ('Ruca','54321','2017-04-11 10:03:21',200,'10010');

insert into radiography(name, VAT_owner,date_timestamp,num,file)
  values('Joa','12346','2017-01-09 10:10:20',451,'path/path');

insert into test_procedure(name,VAT_owner,date_timestamp,num,type)
  values('Joa','12346','2017-01-09 10:10:20',450,'blood'),
  ('Garfield','10011','2002-03-03 10-03-30',35,'urine'),
  ('Ruca','54321','2017-04-11 10:03:21',200,'blood');

insert into produced_indicator(name,VAT_owner,date_timestamp,num,indicator_name,value)
  values('Joa','12346','2017-01-09 10:10:20',450,'indicator1', '80'),
  ('Ruca','54321','2017-04-11 10:03:21',200,'creatinine level', '1.1'),
  ('Garfield','10011','2002-03-03 10-03-30',35,'indicator4','25');
