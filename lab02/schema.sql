--Author: Jack Jiang
--Data: 8/08/2017
--Description: Schema for simple company database for Lab2 in COMP9311

create table Employees (
        tfn         char(11) CHECK (tfn ~ '^(\d{3}-){2}\d{3}$'),
        givenName   varchar(30) NOT NULL,
        familyName  varchar(30),
        hoursPweek  float CONSTRAINT resonable_working_hours CHECK (hoursPweek <= 168 And hoursPweek>= 0),
        primary key (tfn)
);

create table Departments (
        id          char(3) CONSTRAINT valid_id CHECK (id ~ '^\d{3}$'),
        name        varchar(100) UNIQUE,
        manager     char(11) not null unique references Employees(tfn),
        primary key (id)
);

create table DeptMissions (
        department  char(3) references Departments(id),
        keyword     varchar(20),
        primary key (department, keyword)
);

create table WorksFor (
        employee    char(11) references Employees(tfn),
        department  char(3) references Departments(id),
        percentage  float CONSTRAINT resonable_percentage CHECK (percentage >= 0.00 And percentage<= 100),
        primary key (employee, department)
);
