# 1. Introduction, Data Modelling, ER Notation

## Introduction

### General

- database: a collection of related data
- DBMS: database management system
- Database system: the database and DBMS together
- DBA: database administrator

### Database system languages

- DML: data manipulation language, such as queries, updates
- DDL: data defination language, such as data structure, constraints
- PL/SQL: Procedural Language/Structured Query Language

## Data Modleing

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
  - nerver changing
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

# 2. Relational Model, ER-Relational Mapping, SQL Schemas

## Relational Data Modle

- a collection of inter-connected relations (or tables), must has a key
  - relation ~ table
  - tuple ~ row ~ record
  - attribute ~ column ~ field
- shechma
  - description or defination of database
  - not expected to change frenquently
  - a set of table and integrity constraint
- instance
  - a snapshot of database at a monment
  - all the integrity constraint are satisfied
- metadata
  - data about data
  - for example: schma

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

# 3. DBMSs, Databases, Data Modification

# 4. SQL Queries

# 5. More SQL Queries, Stored Procedures

# 6. Extending SQL: Queries, Functions, Aggregates, Triggers

# 7. More Triggers, Programming with Databases

# 8. Catalogs, Privileges

# 9. Relational Design Theory, Normal Forms

# 10. Relational Algebra, Query Processing

# 11. Transaction Processing, Concurrency Control