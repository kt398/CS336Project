CREATE DATABASE IF NOT EXISTS Travel_Reservations;
USE Travel_Reservations;

#Entities
create table if not exists Airports
(
	airportID integer not null,
	airportName text,
	city text,
    country text,
    primary key(airportID)
);

create table if not exists Accounts
(
	username text not null,
    accountNumber integer not null auto_increment,
    password text not null,
    primary key (accountNumber)
);

create table if not exists Customers
(
	firstName text,
    lastName text,
    email text not null,
    creationDate DATE,
    creditCard integer,
    address text,
    city text,
    state text,
    zip integer,
    phone integer
);

create table if not exists Manager
(
	employeeNumber integer not null auto_increment,
    password text not null,
    accountNumber integer not null,
    username text not null,
    primary key (employeeNumber)
	
);

create table if not exists Airlines
(
	airlineID integer not null,
    airlineName text,
    primary key(airlineID)
);

create table if not exists Reservations
(
	date DATE,
    passengers text,
    cRep text,
    bFee integer,
    tFare integer,
    reserverationNumber integer not null
);

#insert into Accounts (username, accountNumber, password)
#values ("bob",5,"hello");
create table if not exists Flights
(
	workingDays text,
    flightNumber integer not null,
    airline text(15) not null,
    seats text,
    fares text,
    primary key (flightNumber, airline(15))
);
create table if not exists Legs
(
	fromAirport text(15) not null,
    toAirport text(15) not null,
    seatNum integer,
    meals text(15) not null,
    class text(15) not null,
    flightNum integer,
    primary key(fromAirport(15),toAirport(15),flightNum)
);

#Relationships
create table if not exists ArrivesAt
(
	airportID integer,
    flightNum integer,
    airline text(15),
    arrivalTime time,
    primary key(airportID, airline(15), flightNum),
    foreign key(airportID) references Airports(airportID),
    foreign key(flightNum,airline(15)) references Flights(flightNumber, airline)
);

create table if not exists DepartsFrom
(
	airportID integer,
    flightNumber integer,
    airline text(15),
    departureTime time,
    #foreign key(airportID) references Airports(airportID),
    foreign key(flightNumber,airline(15)) references Flights(flightNumber, airline),
    primary key(airportID, airline(15), flightNumber)
);

create table if not exists Operates
(
	airlineID integer,
    flightNum integer,
    airline text(15),
    primary key(airlineID,flightNum,airline),
    foreign key(airlineID) references Airlines,
    foreign key(flightNum,airline) references Flights
);
create table if not exists Associated
(
	flightNum integer not null,
    fromAirport integer not null,
    primary key(flightNum,fromAirport),
    foreign key(flightNum) references flight
    #NEED TO FINISH THIS
);

create table if not exists Have
(
	fromAirport text(15) not null,
    toAirport text(15) not null,
    flightNum integer not null,
    reservationNum integer not null,
	primary key(fromAirport,toAirport,flightNum,reservationNum),
    foreign key(fromAirport,toAirport,flightNum) references Legs,
    foreign key(reservationNum) references Reservations
);
create table if not exists Manages
(
	accountNum integer not null,
    employeeNum integer not null,
    primary key(accountNum,employeeNum),
    foreign key(employeeNum) references Manager,
    foreign key(accountNum) references Accounts
);
    
create table if not exists Owns
(
	email text(15) not null,
    accountNum integer not null,
    primary key(email,accountNum),
    foreign key(email) references Customers,
    foreign key(accountNum) references Accounts
);

create table if not exists Contain
(
	reservationNum integer not null,
    accountNum integer not null,
    primary key(reservationNum, accountNum),
    foreign key(reservationNum) references Reservations, 
	foreign key(accountNum) references Accounts
);