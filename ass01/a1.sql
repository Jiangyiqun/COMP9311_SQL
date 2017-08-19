-- COMP9311 17s2 Assignment 1
-- Schema for OzCars
--
-- Date: 15/08/2017
-- Student Name: Jack (Yiqun Jiang)
-- Student ID: z5129432
--

-- Some useful domains; you can define more if needed.

-- EMPLOYEE
create domain TFNType as
	char(9) check (value ~ '[0-9]{9}');

create domain MechanicLicenseType as
	char(8) check (value ~ '[0-9A-Za-z]{8}');

-- CLIENT
create domain ABNType as
	char(11) check (value ~ '([0-9]{9}');

create domain URLType as
	varchar(100) check (value like 'http://%');

create domain EmailType as
	varchar(100) check (value like '%@%.%');

create domain PhoneType as
	char(10) check (value ~ '[0-9]{10}');

-- CAR
create domain VINType as
	char(17) check (value ~ '[0-9A-HJ-NPR-Za-z]{17}');

create domain CarLicenseType as
    varchar(6) check (value ~ '[0-9A-Za-z]{1，6}');

create domain OptionType as 
	varchar(12) check (value in ('sunroof','moonroof','GPS','alloy wheels','leather'));

create domain MonetaryAmounts as
	NUMERIC(8, 2) check (value > 0);

-- RepairJob
create domain JobNumber as
	integer check (value > 0 and value < 1000);


-- EMPLOYEE
create table Employee (
	EID         serial primary key, 
	firstName	varchar(50) not null,
	lastName	varchar(50) not null,
	TFN 		TFNType not null unique,
    salary      integer not null check (Salary > 0)
);

-- Admin
create table Admin (
	EID integer references Employee(EID) primary key
);

-- Mechanic
create table Machanic (
	EID integer references Employee(EID) primary key,
    license 	MechanicLicenseType not null unique
);

-- Salesman
create table Salesman (
	EID integer references Employee(EID) primary key,
	commRate 	integer check (CommRate >= 5 And CommRate <= 20) not null
);

-- CLIENT
create table Client (
	CID         serial primary key,
	name 		varchar(100) not null,
	address 	varchar(200) not null,
	phone 		PhoneType not null,
	email 		EmailType
);

-- Company
create table Company (
	CID integer references Client(CID),
	ABN 		ABNType not null unique,
	URL 		URLType
);

-- CAR
create table Car (
	VIN 	VINType primary key,
	manufacturer	varchar(40) not null,
	model 	varchar(40) not null,
	year 	integer constraint ValidYear check (year >= 1970 and year <= 2099) not null
);

-- UsedCar
create table UsedCar (
	VIN VINType references Car(VIN) primary key,
	plateNumber CarLicenseType not null unique
);

-- NewCar
create table NewCar (
	VIN VINType references Car(VIN) primary key,
	"cost" 	MonetaryAmounts not null,
	charges MonetaryAmounts not null
);

-- Options
create table Options (
	VIN VINType references Car(VIN),
	options OptionType,
	primary key (VIN, options)
);

-- RepairJob
create table RepairJob (
	"number" JobNumber,
	car 	VINType references UsedCar(VIN),
	primary key("number", car),
	client 	integer references Client(CID) not null unique,
	description  varchar(250) not null,
	partsCost   MonetaryAmounts not null,
	workCost	MonetaryAmounts not null,
	"date"		date not null
);

-- Does
create table Does (
	"number" JobNumber,
	car VINType,
	foreign key ("number", car) references RepairJob("number", car),
	mechanic 	integer references Machanic(EID),
	primary key("number", Car, mechanic)
);

--Buys
create table Buys (
	car VINType references UsedCar(VIN),
	"date"	date,
	primary key(Car, "date"),
	salesman integer references Salesman(EID) not null unique,
	client integer references Client(CID) not null,
	price MonetaryAmounts not null,
	commission MonetaryAmounts not null
);

--Sells
create table Sells (
	car VINType references UsedCar(VIN),
	"date"	date,
	primary key(Car, "date"),
	salesman integer references Salesman(EID) not null unique,
	client integer references Client(CID) not null,
	price MonetaryAmounts not null,
	commission MonetaryAmounts not null
);

--SellsNew
create table SellsNew (
	plateNumber CarLicenseType primary key,
	car VINType references NewCar(VIN),
	"date"	date,
	salesman integer references Salesman(EID) not null unique,
	client integer references Client(CID) not null,
	price MonetaryAmounts not null,
	commission MonetaryAmounts not null
);