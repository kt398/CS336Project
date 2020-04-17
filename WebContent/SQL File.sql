CREATE DATABASE IF NOT EXISTS Travel_Reservations;
USE Travel_Reservations;

#Entities
create table if not exists Airports
(
	id char(7) not null,
	aName char(80),
	city char(50),
    country char(50),
    primary key(id)
);

create table if not exists Accounts
(
	username char(15) not null,
    accNum integer not null auto_increment,
    password char(15) not null,
    primary key (accNum)
);

create table if not exists Customers
(
    firstName char(15),
    lastName char(15),
    email char(30) not null,
    creationDate DATE,
    creditCard char(20),
    address char(15),
    city char(15),
    state char(15),
    zip char(5),
    phone char(10),
	ccv integer,
    primary key(email)
);
create table if not exists Owns
(
	email char(30) not null,
    accNum integer not null,
    foreign key(accNum) references accounts(accNum),
	foreign key(email) references customers(email) on delete cascade,
    primary key(email(30),accNum)
);

create table if not exists Manager
(
	employeeNum integer not null auto_increment,
    password char(15) not null,
    username char(15) not null,
    primary key (employeeNum)
);

create table if not exists Airlines
(
	id char(5) not null,
    name  char(30) unique,
    primary key(id)
);
create table if not exists Operates
(
	airlineID char(5),
    flightNum integer,
    airline char(30),
    primary key(airlineID,flightNum,airline),
    foreign key(airline) references Airlines(name),
    foreign key(flightNum,airlineID) references Flights(flightNum,airline)
);


create table if not exists Reservations
(
	date DATE,
    passengers char(15),
    cRep char(15),
    bFee integer,
    tFare integer,
    resNum integer not null,
    primary key(resNum)
);

create table if not exists Flights
(
    flightNum integer not null,
    airline char(15) not null,
    primary key (flightNum, airline)
);
create table if not exists Legs
(
	legID integer not null,
    seatNum integer,
    meals char(15),
    class char(15),
    primary key(legID)
);

create table if not exists goTo(
	flightNum integer,
    airline char(20),
    originAirportID char(7),
    destinationAirportID char(7),
    distance integer,
    workingDay integer,
    arrivalTime time,
    departureTime time,
    primary key(flightNum,airline,originAirportID,destinationAirportID),
    foreign key(flightNum,airline) references Flights(flightNum,airline),
    foreign key(destinationAirportID) references Airports(id),
    foreign key(originAirportID) references Airports(id)
);

create table if not exists Fares(
    fare int,
    distance integer,
	primary key(distance)
);


create table if not exists Have
(
    legID integer not null,
    resNum integer not null,
	primary key(resNum,legID),
    foreign key(legID) references Legs(legID),
    foreign key(resNum) references Reservations(resNum)
);
create table if not exists Manages
(
	accNum integer not null,
    employeeNum integer not null,
    primary key(accNum,employeeNum),
    foreign key(employeeNum) references Manager(employeeNum),
    foreign key(accNum) references Accounts(accNum)
);
create table if not exists Contain
(
	resNum integer not null,
    accNum integer not null,
    primary key(resNum, accNum),
    foreign key(resNum) references Reservations(resNum),
	foreign key(accNum) references Accounts(accNum)
);

create table if not exists Associated
(
	legID integer not null,
    airline char(15) not null,
    flightNum integer not null,
    primary key(legID, flightNum,airline),
    foreign key(flightNum,airline) references flights(flightNum,airline),
    foreign key(legID) references legs(legID)
);

insert into Operates(airlineID, flightNum,airline)
select f.airline, f.flightNum,a.name
from airlines a JOIN flights f ON a.id=f.airline;