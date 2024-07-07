CREATE DATABASE Movie_Venture;
USE Movie_Venture;


# Tickets
CREATE TABLE Tickets
(Ticket_ID CHAR(4),
PRIMARY KEY(Ticket_ID)
);
SELECT * FROM Tickets;

# Ticket Type
CREATE TABLE Ticket_Type
(Ticket_ID CHAR(4),
Type_ID CHAR(4),
Ticket_Type_Name VARCHAR(10),
Price INT,
PRIMARY KEY(Ticket_ID),
FOREIGN KEY (Ticket_ID) REFERENCES Tickets(Ticket_ID)
);
SELECT * FROM Ticket_Type;

# Credit
CREATE TABLE Credit
(Transaction_ID CHAR(4),
Card_No INT,
PRIMARY KEY(Transaction_ID),
FOREIGN KEY (Transaction_ID) REFERENCES Transaction(Transaction_ID)
);
SELECT * FROM Credit;

# Cash
CREATE TABLE Cash
(Transaction_ID CHAR(4),
PRIMARY KEY(Transaction_ID),
FOREIGN KEY (Transaction_ID) REFERENCES Transaction(Transaction_ID)
);
SELECT * FROM Cash;

# Movie
CREATE TABLE Movie
(Movie_No CHAR(4),
Title VARCHAR(50),
Genre VARCHAR(50),
Director VARCHAR(50),
Type VARCHAR(15),
PRIMARY KEY (Movie_No)
);
SELECT * FROM Movie;

# 2D
CREATE TABLE 2_Dimensional
(Movie_No CHAR(4),
PRIMARY KEY (Movie_No),
FOREIGN KEY (Movie_No) REFERENCES Movie(Movie_No)
);
SELECT * FROM 2_Dimensional;

#3D
CREATE TABLE 3_Dimensional
(Movie_No CHAR(4),
PRIMARY KEY (Movie_No),
FOREIGN KEY (Movie_No) REFERENCES Movie(Movie_No)
);
SELECT * FROM 3_Dimensional;

CREATE TABLE Customer_Food
(Food_ID INT,
Customer_ID CHAR(4),
SSN INT,
Purchase_ID Char(4),
Quantity INT,
Transaction_ID Char(4),
PRIMARY KEY (Food_ID, SSN, Transaction_ID),
FOREIGN KEY (SSN) REFERENCES Customer(SSN),
FOREIGN KEY (Transaction_ID) REFERENCES Transactions(Transaction_ID),
FOREIGN KEY (Food_ID) REFERENCES Food_Consignment(Food_ID)
);
SELECT * FROM Customer_Food;

CREATE TABLE Movie
(Movie_No CHAR(4),
Title VARCHAR(50),
Genre VARCHAR(50),
Director VARCHAR(50),
Type VARCHAR(15),
PRIMARY KEY (Movie_No)
);
SELECT * FROM Movie;

INSERT INTO Movie (Movie_No, Title, Genre, Director, Type) VALUES
('001', 'The Matrix', 'Sci-Fi', 'Lana Wachowski', '3D'),
('002', 'Inception', 'Sci-Fi', 'Christopher Nolan', '2D'),
('003', 'Pulp Fiction', 'Crime', 'Quentin Tarantino', '2D'),
('004', 'The Dark Knight', 'Action', 'Christopher Nolan', '2D'),
('005', 'Interstellar', 'Sci-Fi', 'Christopher Nolan', '3D'),
('006', 'Titanic', 'Romance', 'James Cameron', '2D'),
('007', 'Avatar', 'Action', 'James Cameron', '3D'),
('008', 'Jurassic Park', 'Adventure', 'Steven Spielberg', '2D'),
('009', 'The Godfather', 'Crime', 'Francis Ford Coppola', '2D'),
('010', 'Forrest Gump', 'Drama', 'Robert Zemeckis', '2D')
;





INSERT INTO Seat (Seat_ID, SeatType, Room_No) VALUES
('001A', 'recliner', 1),
('002A', 'recliner', 2),
('003A', 'recliner', 3),
('004A', 'regular', 4),
('005A', 'recliner', 5),
('006A', 'regular', 6),
('007A', 'regular', 7),
('008A', 'recliner', 8),
('009A', 'regular', 9),
('010A', 'recliner', 10)
;

#3D
CREATE TABLE 3_Dimensional
(Movie_No CHAR(4),
PRIMARY KEY (Movie_No),
FOREIGN KEY (Movie_No) REFERENCES Movie(Movie_No)
);
SELECT * FROM 3_Dimensional;


CREATE TABLE Showing_Time
(Room_No INT,
Movie_No CHAR(4),
Showing_Time VARCHAR(50),
FOREIGN KEY (Room_No) REFERENCES Room(Room_No),
FOREIGN KEY (Movie_No) REFERENCES Movie(Movie_No)
);
SELECT * FROM Showing_Time;
drop table Showing_Time;

INSERT INTO Showing_Time (Room_No, Movie_No, Showing_Time) VALUES
(1, '001', '2024-03-12 12:00:00 PM'),
(2, '002', '2024-03-12 01:00:00 PM'),
(3, '003', '2024-03-12 02:00:00 PM'),
(4, '004', '2024-03-12 03:00:00 PM'),
(5, '005', '2024-03-12 04:00:00 PM'),
(6, '006', '2024-03-12 05:00:00 PM'),
(7, '007', '2024-03-12 06:00:00 PM'),
(8, '008', '2024-03-12 07:00:00 PM'),
(9, '009', '2024-03-12 08:00:00 PM'),
(10, '010', '2024-03-12 09:00:00 PM')
;


INSERT INTO Glasses (Glasses_ID, Status) VALUES
('001', 'Available'),
('002', 'Available'),
('003', 'In Use')
;


CREATE TABLE Tickets
(Ticket_ID CHAR(4),
Customer_ID CHAR(4),
SSN INT, 
Type_ID CHAR(4),
Movie_No Char(4),
PRIMARY KEY (Ticket_ID, SSN),
FOREIGN KEY (SSN) REFERENCES Customer(SSN),
FOREIGN KEY (Type_ID) REFERENCES Ticket_Type(Type_ID),
FOREIGN KEY (Movie_No) REFERENCES Movie(Movie_No)
);
SELECT * FROM Tickets;
drop table Tickets;
drop table Reservation;

INSERT INTO Tickets (Ticket_ID, Customer_ID, SSN, Type_ID, Movie_No) VALUES
('001', '3921', 456, '001', '001'),
('002', '0329', 789, '002', '002'),
('003', '9482', 830, '003', '003'),
('004', '1947', 837, '004', '004'),
('005', '2854', 483, '005', '005'),
('006', '4329', 784, '001', '006'),
('007', '5728', 594, '002', '007'),
('008', '7845', 803, '003', '008'),
('009', '0274', 184, '004', '009'),
('010', '1848', 163, '005', '010')
;



SELECT M.Genre, COUNT(T.Ticket_ID) AS Total_Tickets_Sold
FROM Movie M
INNER JOIN Tickets T ON M.Movie_No = T.Movie_No
GROUP BY M.Genre;
SELECT M.Title, COUNT(*) as Tickets_Sold
FROM Movie M
JOIN Tickets T ON M.Movie_No = T.Movie_No
GROUP BY M.Title
HAVING COUNT(*) = (SELECT MAX(Tickets_Sold) FROM (SELECT COUNT(*) as Tickets_Sold FROM Tickets GROUP BY Movie_No) as T);

SELECT FC.FoodName, SUM(CF.Quantity) as Total_Sold
FROM Food_Consignment FC
JOIN Customer_Food CF ON FC.Food_ID = CF.Food_ID
GROUP BY FC.FoodName
ORDER BY Total_Sold DESC
LIMIT 1;

SELECT M.Title, S.Showing_Time, S.Room_No
FROM Movie M
INNER JOIN 3_Dimensional T ON M.Movie_No = T.Movie_No
INNER JOIN Showing_Time S ON M.Movie_No = S.Movie_No;

SELECT E.SSN, E.Title, M.SSN AS Manager_SSN, M.Title AS Manager_Title
FROM Employee E
LEFT JOIN Employee M ON E.Manager_SSN = M.Emp_ID;


