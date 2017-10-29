# COMP9311 Review

## 1. Introduction, Data Modelling, ER Notation

### General

- database: a collection of related data
- DBMS: database management system
- Database system: the database and DBMS together
- DBA: database administrator

### Database system languages

- DML: data manipulation language, such as queries, updates
- DDL: data definition language, such as data structure, constraints
- PL/SQL: Procedural Language/Structured Query Language

### ER: Entity Relationship

- attribute (column)
- entity(rows)
- relationship

### EDR entity relationship diagram

- [ER Diagram Representation](.\er_diagram_representation.pdf)
- ![every course has exactly one lecture](every_course_has_exactly_one_lectures.png)
- total participation
- partial participation
- one to one
- one to many
- many to many

### Keys

- PK: Primary key
  - one candidate key
  - unique
  - not null
  - never changing
- composite primary key
  - use fewest attribute
  - never changing
- FK: foreign key
  - a primary key stored in a foreign table
- superkey(keys):
  - distinct
- candidate key:
  - no subset is superkey
- weak entity:
  - In more technical terms it can be defined as an entity that cannot be identified by its own attributes. It uses a foreign key combined with its attributed to form the primary key.

### Subclass

- overlapping
- disjoint
- partial
- total

## 2. Relational Model, ER-Relational Mapping, SQL Schemas

### Relational Data Model

- a collection of inter-connected relations (or tables), must has a key
  - relation ~ table
  - tuple ~ row ~ record
  - attribute ~ column ~ field
- schema
  - description or definition of database
  - not expected to change frequently
  - a set of table and integrity constraint
- instance
  - a snapshot of database at a moment
  - all the integrity constraint are satisfied
- metadata
  - data about data
  - for example: schema

### Difference between ER and relational Model

- Rel has no composite or multi-valued attributes (atomic)
- Rel has no subclass or inheritance
- ![mapping multi-valued attribute](mapmva.png)
- ![ER style subclass mapping](mapsubclass.png)

```text

FavColour(12345, red)
FavColour(12345, green)
FavColour(12345, blue)
FavColour(54321, green)
FavColour(54321, purple)

```

### Mapping ER to relational model

- to be noticed:
  - this mapping lack of constraints
- binary relationship
  - ![Mapping strong entities](strongent.png)
  - ![Mapping 1:n or 1:1 relationships](mapwkent.png)
  - ![Mapping N:M Relationships](mapnnrel.png)
    - a separate table is needed
- n-ways relationships
  - ![first method](medical1.png)

```postgreSQL

  -- Mapping of ER diagram with Prescription as relationship

create domain NameValue as varchar(100) not null;
--  character varying (100)

create table Drug (
	dno         integer, -- unique not null because PK
	name        NameValue unique, -- not null from domain
	formula     text,    -- can be null
	primary key (dno)
);

create table Patient (
	pid         integer,  -- unique not null because PK
	name        NameValue, -- not null from domain
	address     text not null,
	primary key (pid)
);

create table Doctor (
	tfn         integer, -- unique not null because PK
	name        NameValue, -- not null from domain
	specialty   text not null,
	primary key (tfn)
);

create table Prescribes (
	drug        integer references Drug(dno),
	doctor      integer not null references Doctor(tfn),
	patient     integer references Patient(pid),
	quantity    integer not null,
	"date"      date,
	primary key ("date",patient,drug)
	-- allows a patient to be prescribed 
	-- a given drug only once on a given day 
);

-- think about the implications of alternative primary keys
-- primary key(patient)
-- primary key(drug)
-- primary key("date")
-- primary key(patient,"date")
-- primary key(patient,"date",drug,doctor)

```

  - ![second method](medical2.png)

```postgreSQL

-- Mapping of ER diagram with Prescription as an Entity

create domain NameValue as varchar(100) not null;
--  character varying (100)

create table Drug (
	dno         integer, -- unique not null because PK
	name        NameValue unique, -- not null from domain
	formula     text,    -- can be null
	primary key (dno)
);

create table Patient (
	pid         integer,  -- unique not null because PK
	name        NameValue, -- not null from domain
	address     text not null,
	primary key (pid)
);

create table Doctor (
	tfn         integer, -- unique not null because PK
	name        NameValue, -- not null from domain
	specialty   text not null,
	primary key (tfn)
);

create table Prescription (
	prNum       integer,
	"date"      date not null,
	doctor      integer not null references Doctor(tfn), -- n:1 relationship
	patient     integer not null references Patient(pid), -- n:1 relationship
	primary key (prNum)
);

create table PrescriptionItem (
	prescription integer references Prescription(prNum),
	drug         integer references Drug(dno),
	quantity     integer check (quantity > 0),
	primary key  (prescription,drug)
);

```

### DBMS Terminology

- DBMS
- database
- schema
- table
- attribute

### Integrity Constraint

- Key constraint / entity constraint
  - unique, not null
- domain constraint
- referential constraint / foreign key constraint
  - the value must exist / or null
  - is a primary key in another table

## 3. DBMS, Databases, Data Modification

## 4. SQL Queries

## 5. More SQL Queries, Stored Procedures

## 6. Extending SQL: Queries, Functions, Aggregates, Triggers

## 7. More Triggers, Programming with Databases

## 8. Catalogs, Privileges

## 9. Relational Design Theory, Normal Forms

## 10. Relational Algebra, Query Processing

## 11. Transaction Processing, Concurrency Control