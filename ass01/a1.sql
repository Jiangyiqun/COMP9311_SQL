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
	FirstName	varchar(50) not null,
	LastName	varchar(50) not null,
	TFN 		TFNType not null unique,
    Salary      integer not null check (Salary > 0),
    license 	MechanicLicenseType unique,
    CommRate 	integer check (CommRate >= 5 And CommRate <= 20),
	constraint  DisjointEmployee check (
		(license is null and CommRate is not null) or
		(license is not null and CommRate is null) or
		(license is null and CommRate is null)
	)
);

-- CLIENT
create table Client (
	CID         serial primary key,
	Name 		varchar(100) not null,
	Address 	varchar(200) not null,
	Phone 		PhoneType not null,
	Email 		EmailType,
	ABN 		ABNType,
	URL 		URLType,
	constraint ValidPersonalClient check (
		(ABN is null and URL is null)or		-- if it is a person
	 	(ABN is not null)	-- if it is a company
	)
);

-- CAR
create table Car (
	VIN 	VINType primary key,
	manufacturer	varchar(40) not null,
	model 	varchar(40) not null,
	year 	integer constraint ValidYear check (year >= 1970 and year <= 2099) not null,
	"cost" 	MonetaryAmounts,
	charges MonetaryAmounts,
	plateNumber CarLicenseType unique,
	constraint ValidCarType check (
		("cost" is not null and charges is not null and plateNumber is null) or 	-- if it is a used car 
		("cost" is null and charges is null and plateNumber is not null)		-- if it is a new car
	)
);

create table Option (
	VIN VINType references Car(VIN),
	option OptionType,
	primary key (VIN, option)
);

-- RepairJob
create table RepairJob (
	"number" JobNumber,
	Car 	VINType references Car(VIN) not null unique,
	primary key("number", Car),
	plateNumber CarLicenseType references Car(plateNumber) not null unique,
	Client 	integer references Client(CID) not null unique,
	Description  varchar(250) not null,
	PartsCost   MonetaryAmounts not null,
	WorkCost	MonetaryAmounts not null,
	"Date"		date not null
);

-- Does
create table Does (
	"number" JobNumber,
	Car VINType references RepairJob(Car),
	Mechanic 	integer references Employee(EID),
	primary key("number", Car, Mechanic),
	license 	MechanicLicenseType references Employee(license) not null unique
);

--Buys
create table Buys (
	Car VINType references Car(VIN),
	"Date"	date,
	primary key(Car, "Date"),
	plateNumber CarLicenseType references Car(plateNumber) not null unique,
	Salesman integer references Employee(EID) not null unique,
	-- CommRate 	integer references Employee(CommRate) not null,
	Client integer references Client(CID) not null,
	price MonetaryAmounts not null,
	commission MonetaryAmounts not null
);

--Sells
create table Sells (
	Car VINType references Car(VIN),
	"Date"	date,
	primary key(Car, "Date"),
	plateNumber CarLicenseType references Car(plateNumber) not null unique,
	Salesman integer references Employee(EID) not null unique,
	-- CommRate 	integer references Employee(CommRate) not null,
	Client integer references Client(CID) not null,
	price MonetaryAmounts not null,
	commission MonetaryAmounts not null
);

--SellsNew
create table SellsNew (
	plateNumber CarLicenseType primary key,
	Car VINType references Car(VIN) not null unique,
	"Date"	date not null not null,
	Salesman integer references Employee(EID) not null unique,
	-- CommRate 	integer references Employee(CommRate) not null,
	Client integer references Client(CID) not null,
	price MonetaryAmounts not null,
	commission MonetaryAmounts not null
);