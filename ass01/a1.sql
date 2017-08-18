-- COMP9311 17s2 Assignment 1
-- Schema for OzCars
--
-- Date: 15/08/2017
-- Student Name: Jack (Yiqun Jiang)
-- Student ID: z5129432
--

-- Some useful domains; you can define more if needed.

create domain URLType as
	varchar(100) check (value like 'http://%');

create domain EmailType as
	varchar(100) check (value like '%@%.%');

create domain PhoneType as
	char(10) check (value ~ '[0-9]{10}');

create domain TFNType as
	char(11) check (value ~ '^([0-9]{9}$');

create domain ABNType as
	char(11) check (value ~ '^([0-9]{9}$');

create domain MechanicLicenseType as
	varchar(8) check (value ~ '[0-9A-Za-z]{8}');

create domain CarLicenseType as
    varchar(6) check (value ~ '[0-9A-Za-z]{1，6}');

create domain OptionType as 
	varchar(12) check (value in ('sunroof','moonroof','GPS','alloy wheels','leather'));

create domain VINType as
	char(17) check (value ~ '[0-9A-HJ-NPR-Za-hj-npr-z]{17}');

create domain JobNumber as
	integer(3) check (value > 0);

create domain MonetaryAmounts as
	integer(3) check (value > 0);-------------?????????????

-- EMPLOYEE
create table Employee (
	EID          serial, 
	TFN 		 TFNType unique not null,
    Salary       integer not null check (Salary > 0),
    license 	MechanicLicenseType unique,
    CommRate 	integer check (CommRate > 5 And CommRate < 20),
	primary key (EID),
	constraint  DisjointEmployee check (
		(license is null and CommRate is not null) or
		(license is not null and CommRate is null) or
		(license is null and CommRate is null)
	)
);

create table Name (
	EID			serial references Employee(EID),
	FirstName	varchar(50) not null,
	LastName	varchar(50) not null,
	primary key (EID)
);


-- CLIENT
create table Client (
	CID          serial,
	Name 		 varchar(100),
	Address 	varchar(200)，
	Phone 		PhoneType,
	Email 		EmailType,
	ABN 		ABNType,
	URL 		URLType，
	primary key (CID)，
	constraint ValidPersonalClient check (
		（ABN is null）or
		(ABN is not null and Name is not null and Address is not null and Phone is not null)
	)
);


-- CAR
create table Car (
	VIN 	VINType,
	manufacturer	varchar(40),
	model 	varchar(40),
	year 	integer(4) constraint ValidYear check (year >= 1970 and year <= 2099),
	cost 	money,
	charges money,
	plateNumber CarLicenseType,
	primary key (VIN)
);


create table Option (
	VIN VINType references Car(VIN),
	option OptionType,
	primary key (VIN, option)
);

-- RepairJob
create table RepairJob (
	"number" JobNumber,
	Mechanic 	serial not null references Employee(EID),
	Car 	VINType not null unique references Car(VIN),
	Client 	serial not null references Client(CID),
	Description  varchar(250),
	PartCost   MonetaryAmounts,
	WorkCost	MonetaryAmounts,
	"Date"		date,
	primary key ("number", Mechanic, Car, Client)
);c

--Buys
create table Buys (
	Salesman serial unique references Employee(EID),
	Client serial references Client(CID),
	Car VINType references Car(VIN),
	price MonetaryAmounts,
	"Date"	date,
	commission MonetaryAmounts,
	primary key (Salesman, Client, Car)
);

--Sells
create table Sells (
	Salesman serial unique references Employee(EID),
	Client serial references Client(CID),
	Car VINType references Car(VIN),
	"Date"	date,
	price MonetaryAmounts,
	commission MonetaryAmounts,
	primary key (Salesman, Client, Car)
);

--SellsNew
create table SellsNew (
	Salesman serial unique references Employee(EID),
	Client serial references Client(CID),
	Car VINType references Car(VIN),
	commission MonetaryAmounts,
	"Date"	date,
	price MonetaryAmounts,
	plateNumber CarLicenseType,
	primary key (Salesman, Client, Car)
);