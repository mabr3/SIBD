drop table if exists produced_indicator;
drop table if exists test_procedure;
drop table if exists indicator cascade;
drop table if exists radiography cascade;
drop table if exists performed cascade;
drop table if exists _procedure;
drop table if exists prescription cascade;
drop table if exists consult_diagnosis cascade;
drop table if exists medication cascade;
drop table if exists diagnosis_code cascade;
drop table if exists participation cascade;
drop table if exists consult cascade;
drop table if exists animal cascade;
drop table if exists generalization_species cascade;
drop table if exists species cascade;
drop table if exists client cascade;
drop table if exists assistant cascade;
drop table if exists veterinary cascade;
drop table if exists phone_number cascade;
drop table if exists person cascade;

create table person
  (VAT varchar(15),
   name  varchar(150) not null,
   address_street  varchar(150) not null,
   address_city varchar(50) not null,
   address_zip varchar (20) not null,
   primary key(VAT));

create table phone_number
  (phone varchar(20),
  VAT varchar(15),
  primary key(VAT,phone),
  foreign key(VAT) references person(VAT) on delete cascade on update cascade);

create table client
  (VAT varchar(15),
  primary key(VAT),
  foreign key(VAT) references person(VAT) on delete cascade on update cascade);

create table veterinary
  (VAT varchar(15),
  specialization varchar(30) not null,
  bio varchar(500) not null,
  primary key(VAT),
  foreign key(VAT) references person(VAT) on delete cascade on update cascade);

create table assistant
  (VAT varchar(15),
  primary key(VAT),
  foreign key(VAT) references person(VAT) on delete cascade on update cascade);

create table species
  (name varchar(50),
  description varchar(500) not null,
  primary key(name));

create table generalization_species
  (name1 varchar(50),
  name2 varchar(50),
  primary key(name1),
  foreign key(name1) references species(name) on delete cascade on update cascade,
  foreign key(name2) references species(name) on delete cascade on update cascade);

create table animal
  (name varchar(30),
  VAT varchar(15),
  species_name varchar(50),
  gender varchar(10) not null,
  colour varchar(25) not null,
  birth_year year not null,
  age int not null,
  primary key(name, VAT),
  foreign key(VAT) references client(VAT) on delete cascade on update cascade,
  foreign key(species_name) references species(name) on delete cascade on update cascade);

create table consult
  (name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  s varchar(200),
  o varchar(200),
  a varchar(200),
  p varchar(200),
  VAT_client varchar(15),
  VAT_vet varchar(15),
  weight float not null check (weight >0),
  primary key(name, VAT_owner, date_timestamp),
  foreign key(name, VAT_owner) references animal(name,VAT) on delete cascade on update cascade,
  foreign key(VAT_client) references client(VAT) on delete cascade on update cascade,
  foreign key(VAT_vet) references veterinary(VAT) on delete cascade on update cascade);

create table participation
  (name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  VAT_assistant varchar(15),
  primary key(name, VAT_owner, date_timestamp, VAT_assistant),
  foreign key(name,VAT_owner,date_timestamp) references consult(name, VAT_owner, date_timestamp) on delete cascade on update cascade,
  foreign key(VAT_assistant) references assistant(VAT) on delete cascade on update cascade);

create table diagnosis_code
  (code varchar(15),
  name varchar(50) not null,
  primary key(code));

create table consult_diagnosis
  (code varchar(15),
  name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  primary key(code,name,VAT_owner,date_timestamp),
  foreign key(code) references diagnosis_code(code) on delete cascade on update cascade,
  foreign key(name,VAT_owner,date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade on update cascade);

create table medication
  (name varchar(30),
  lab varchar(50),
  dosage varchar(15),
  primary key(name, lab, dosage));

create table prescription
  (code varchar(15),
  name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  name_med varchar(30),
  lab varchar(50),
  dosage varchar(15),
  regime varchar(50) not null,
  primary key(code, name, VAT_owner,date_timestamp, name_med, lab, dosage),
  foreign key(code, name, VAT_owner,date_timestamp) references consult_diagnosis(code, name, VAT_owner, date_timestamp) on delete cascade on update cascade,
  foreign key(name_med, lab, dosage) references medication(name, lab, dosage) on delete cascade on update cascade);

create table indicator
  (name varchar(20),
  reference_value float,
  units varchar(15) not null,
  description varchar(200) not null,
  primary key(name));

create table _procedure
  (name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  num int not null,
  description varchar(300),
  primary key(name, VAT_owner,date_timestamp, num),
  foreign key(name, VAT_owner,date_timestamp) references consult(name,VAT_owner,date_timestamp) on delete cascade on update cascade);

create table performed
  (name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  num int not null,
  VAT_assistant varchar(15),
  primary key(name, VAT_owner, date_timestamp, num, VAT_assistant),
  foreign key(name, VAT_owner, date_timestamp, num) references _procedure(name, VAT_owner,date_timestamp, num) on delete cascade on update cascade,
  foreign key(VAT_assistant) references assistant(VAT) on delete cascade on update cascade);

create table radiography
  (name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  num int not null,
  file varchar(100) not null,
  primary key(name, VAT_owner, date_timestamp, num),
  foreign key(name, VAT_owner, date_timestamp, num) references _procedure(name, VAT_owner, date_timestamp, num) on delete cascade on update cascade);

create table test_procedure
  (name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  num int not null,
  type varchar(25) not null check (type in ('blood','urine')),
  primary key(name, VAT_owner,date_timestamp, num),
  foreign key(name, VAT_owner,date_timestamp, num) references _procedure(name, VAT_owner, date_timestamp, num) on delete cascade on update cascade);

create table produced_indicator
  (name varchar(30),
  VAT_owner varchar(15),
  date_timestamp timestamp,
  num int not null,
  indicator_name varchar(20),
  value float,
  primary key(name, VAT_owner, date_timestamp, num, indicator_name),
  foreign key(name, VAT_owner, date_timestamp, num) references test_procedure(name, VAT_owner,date_timestamp,num) on delete cascade on update cascade,
  foreign key(indicator_name) references indicator(name) on delete cascade on update cascade);
