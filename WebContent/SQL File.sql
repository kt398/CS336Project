CREATE DATABASE IF NOT EXISTS Travel_Reservations;
USE Travel_Reservations;

#Entities
create table if not exists Airports
(
	id integer not null,
	aName char,
	city char,
    country char,
    primary key(id)
);


create table if not exists Accounts
(
	username char not null,
    accNum integer not null auto_increment,
    password char not null,
    primary key (accNum)
);

create table if not exists Customers
(
    firstName char(15),
    lastName char(15),
    email char(15) not null,
    creationDate DATE,
    creditCard integer,
    address char(15),
    city char(15),
    state char(15),
    zip integer,
    phone integer,
    primary key(email)
);
create table if not exists Owns
(
	customerEmail char(15) not null,
    accNum integer not null,
    foreign key(accNum) references accounts(accNum),
	foreign key(customerEmail) references customers(email),
    primary key(customerEmail,accNum)
);

create table if not exists Manager
(
	employeeNum integer not null auto_increment,
    password char not null,
    accountNum integer not null,
    username char not null,
    primary key (employeeNum)
	
);

create table if not exists Airlines
(
	id integer not null,
    name char,
    primary key(id)
);

create table if not exists Reservations
(
	date DATE,
    passengers char,
    cRep char,
    bFee integer,
    tFare integer,
    resNum integer not null,
    primary key(resNum)
);

create table if not exists Flights
(
	workingDays char,
    num integer not null,
    airline char(15) not null,
    seats char,
    fares char,
    primary key (num, airline)
);
create table if not exists Legs
(
	id integer not null,
    seatNum integer,
    meals char(15),
    class char(15), 
    primary key(id)
);

#Relationships
create table if not exists ArrivesAt
(
	airportID integer,
    flightNum integer,
    airline char(15),
    arrivalTime time,
    primary key(airportID, airline(15), flightNum),
    foreign key(airportID) references Airports(id),
    foreign key(flightNum,airline) references Flights(num, airline)
);

create table if not exists DepartsFrom
(
	airportID integer,
    flightNum integer,
    airline char(15),
    departureTime time,
	primary key(airportID, airline, flightNum),
    foreign key(airportID) references Airports(id),
    foreign key(flightNum,airline) references Flights(num, airline)
);

create table if not exists Operates
(
	airlineID integer,
    flightNum integer,
    airline char(15),
    primary key(airlineID,flightNum,airline),
    foreign key(airlineID) references Airlines(id),
    foreign key(flightNum,airline) references Flights(num,airline)
);


create table if not exists Have
(

    legID integer not null,
    reservationNum integer not null,
	primary key(reservationNum,legID),
    foreign key(legID) references Legs(id),
    foreign key(reservationNum) references Reservations(resNum)
);
create table if not exists Manages
(
	accountNum integer not null,
    employeeNum integer not null,
    primary key(accountNum,employeeNum),
    foreign key(employeeNum) references Manager(employeeNum),
    foreign key(accountNum) references Accounts(accNum)
);
create table if not exists Contain
(
	reservationNum integer not null,
    accountNum integer not null,
    primary key(reservationNum, accountNum),
    foreign key(reservationNum) references Reservations(resNum),
	foreign key(accountNum) references Accounts(accNum)
);

create table if not exists Associated
(
	legID integer not null,
    airline char(15) not null,
    flightNum integer not null,
    primary key(legID, flightNum,airline),
    foreign key(flightNum,airline) references flights(num,airline),
    foreign key(legID) references legs(id)
);