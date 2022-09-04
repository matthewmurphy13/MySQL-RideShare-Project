

CREATE TABLE `users` (
  `USER_ID` int NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `EMAIL` varchar(45) NOT NULL,
  PRIMARY KEY (`USER_ID`)
);
insert into USERS (USER_ID, NAME, EMAIL) values (1, 'Heinrick Mc Dermid', 
'hen@example.com');
insert into USERS (USER_ID, NAME, EMAIL) values (2, 'Thorvald FitzAlan', 
'thor@example.com');
insert into USERS (USER_ID, NAME, EMAIL) values (3, 'Alfy Spinnace', 
'alfy@example.com');
insert into USERS (USER_ID, NAME, EMAIL) values (4, 'Cheryl Galbreth', 
'cher@example.com');
insert into USERS (USER_ID, NAME, EMAIL) values (5, 'Josiah Bridell', 
'josiah@example.com');
CREATE TABLE `vehicle` (
  `VEHICLE_ID` int NOT NULL,
  `YEAR` varchar(45) DEFAULT NULL,
  `MAKE` varchar(45) DEFAULT NULL,
  `MODEL` varchar(45) DEFAULT NULL,
  `PLATE_NUMBER` varchar(45) DEFAULT NULL,
  `IN_TRANSIT` tinyint DEFAULT NULL,
  PRIMARY KEY (`VEHICLE_ID`)
);
insert into VEHICLE (VEHICLE_ID, YEAR, MAKE, MODEL, PLATE_NUMBER, IN_TRANSIT) 
values (1, '2001', 'Mazda', 'Protege', '3D73Y3CL2BG648554', false);
insert into VEHICLE (VEHICLE_ID, YEAR, MAKE, MODEL, PLATE_NUMBER, IN_TRANSIT) 
values (2, '1997', 'Toyota', 'Land Cruiser', 'JH4DC53852C491429', true);
insert into VEHICLE (VEHICLE_ID, YEAR, MAKE, MODEL, PLATE_NUMBER, IN_TRANSIT) 
values (3, '2013', 'Pontiac', 'Bonneville', 'JH4KB16658C621389', false);
insert into VEHICLE (VEHICLE_ID, YEAR, MAKE, MODEL, PLATE_NUMBER, IN_TRANSIT) 
values (4, '1996', 'Mercedes', 'Benz', '1N6AA0CAXDN430887', false);
CREATE TABLE `passenger` (
  `PASSENGER_ID` int NOT NULL,
  `ACCOUNT_TYPE` varchar(45) NOT NULL,
  `USER_ID` int NOT NULL,
  PRIMARY KEY (`PASSENGER_ID`),
  KEY `PASSENGER_USER_idx` (`USER_ID`),
  CONSTRAINT `PASSENGER_USER` FOREIGN KEY (`USER_ID`) REFERENCES `users` 
(`USER_ID`)
);
insert into passenger values (1, 'PERSONAL', 1);
insert into passenger values (2, 'BUSINESS', 2);
insert into passenger values (3, 'BUSINESS', 3);
CREATE TABLE `driver` (
  `DRIVER_ID` int NOT NULL,
  `VEHICLE_ID` int NOT NULL,
  `USER_ID` int NOT NULL,
  PRIMARY KEY (`DRIVER_ID`),
  KEY `DRIVER_VEHICLE_idx` (`VEHICLE_ID`),
  KEY `DRIVER_USER_idx` (`USER_ID`),
  CONSTRAINT `DRIVER_USER` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `DRIVER_VEHICLE` FOREIGN KEY (`VEHICLE_ID`) REFERENCES `vehicle` 
(`VEHICLE_ID`)
);
insert into driver values (1, 1, 4);
insert into driver values (2, 2, 5);
CREATE TABLE `ride` (
  `RIDE_ID` int NOT NULL,
  `COMPLETED` tinyint NOT NULL,
  `DRIVER_ID` int NOT NULL,
  PRIMARY KEY (`RIDE_ID`),
  KEY `RIDE_DRIVER_idx` (`DRIVER_ID`),
  CONSTRAINT `RIDE_DRIVER` FOREIGN KEY (`DRIVER_ID`) REFERENCES `driver` 
(`DRIVER_ID`)
);
insert into ride values (1, 1, 1);
insert into ride values (2, 1, 2);
insert into ride values (3, 0, 2);
CREATE TABLE `ride_passengers` (
  `RIDE_ID` int NOT NULL,
  `PASSENGER_ID` int NOT NULL,
  PRIMARY KEY (`RIDE_ID`,`PASSENGER_ID`),
  KEY `PASS_NUM_idx` (`PASSENGER_ID`),
  CONSTRAINT `PASS_NUM` FOREIGN KEY (`PASSENGER_ID`) REFERENCES `passenger` 
(`PASSENGER_ID`),
  CONSTRAINT `RIDE_NUM` FOREIGN KEY (`RIDE_ID`) REFERENCES `ride` (`RIDE_ID`)
);
insert into ride_passengers values (1, 1);
insert into ride_passengers values (2, 2);
insert into ride_passengers values (3, 1);
insert into ride_passengers values (3, 2);
insert into ride_passengers values (3, 3);

SELECT * 
FROM PASSENGER
WHERE PASSENGER_ID = 1;

# UPDATING PASSENGER 1 TO A BUSINESS ACCOUNT
UPDATE PASSENGER
SET ACCOUNT_TYPE = 'BUSINESS'
WHERE PASSENGER_ID = 1;

#FIND ALL PASSENGERS IN THE DATABASE
SELECT * FROM USERS
LEFT JOIN PASSENGER
ON PASSENGER.USER_ID = USERS.USER_ID
WHERE PASSENGER.USER_ID = USERS.USER_ID;

#FIND ALL RECORDS WHERE RIDES HAVE BEEN COMPLETED
SELECT *
FROM RIDE 
WHERE COMPLETED = 1;

#LIST ALL USERS IN THE DATABASE
SELECT
	NAME,
    EMAIL
FROM USERS;
 
#FIND ALL VEHICLES WITH A MAKE THAT BEGINS WITH M
SELECT*
FROM VEHICLE
WHERE MAKE
LIKE 'M%';