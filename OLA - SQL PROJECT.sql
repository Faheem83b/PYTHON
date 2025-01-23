create Database Ola;
DROP Database Ola;
use ola;
drop table Bookings;
create table Bookings(
Booking_Date date,
Booking_Time varchar(100),
Booking_ID Varchar(100),
Booking_status Varchar(100),
Customer_Id varchar(100),
Vehicle_Type varchar(100),
Pickup_location varchar(100),
Drop_location varchar(100),
V_TAT int,
C_TAT int,
Canceled_Rides_By_Customer varchar(100),
Canceled_Rides_By_Driver varchar(100),
Incomplete_Rides varchar(50),
Incomplete_Rides_Reasons varchar(50),
Booking_Value int,
Payment_Method varchar(50),
Ride_Distance int,
Driver_Rating float,
Customer_Rating float,
Vehicle_Images varchar(100)
);


SET GLOBAL LOCAL_INFILE=ON;
LOAD DATA LOCAL INFILE 'C:/Users/91703/Downloads/Bookings-20000-Rows.csv' INTO TABLE Bookings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * FROM Bookings;

#TO COUNT THE NO OF ROWS IN THE FILE
SELECT COUNT(*) AS row_count
FROM Bookings;

#TO SELECT ONLY TOP 10 ROWS 
SELECT *
FROM Bookings
LIMIT 10;


#1. Retrieve all successful bookings:

create view successful_Bookings as
SELECT * FROM Bookings WHERE Booking_status = 'Success';

select * from successful_Bookings;


#2. Find the average ride distance for each vehicle type:

create view average_ride_distance_for_each_vehicle_type as
SELECT Vehicle_Type, AVG(Ride_Distance)
 as avg_distance FROM bookings
 GROUP BY Vehicle_Type;
 
 select * from average_ride_distance_for_each_vehicle_type;
 

#3. Get the total number of cancelled rides by customers:

Create view number_of_cancelled_rides_by_customers as
 SELECT COUNT(*) FROM bookings
 WHERE Booking_Status = 'cancelled by Customer';
 
select * from number_of_cancelled_rides_by_customers;


#4. List the top 5 customers who booked the highest number of rides:

create view the_highest_number_of_ride_by_the_top_5_customers as
select Customer_ID, COUNT(Booking_ID) as TOTAL_RIDES FROM Bookings
GROUP BY Customer_ID
ORDER BY TOTAL_RIDES DESC LIMIT 5;

select * from the_highest_number_of_ride_by_the_top_5_customers;


#5. Get the number of rides cancelled by drivers due to personal and car-related issues:


create view number_of_rides_cancelled_by_drivers as
select COUNT(*) from Bookings
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

select * from number_of_rides_cancelled_by_drivers;


#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

create view maximum_and_minimum_driver_ratings as
select MAX(Driver_Rating) as max_rating,
MIN(Driver_Rating) as min_rating
from Bookings where Vehicle_Type = 'Prime Sedan';

select * from maximum_and_minimum_driver_ratings;

#7. Retrieve all rides where payment was made using UPI:

create view UPI_PAYMENTS as 
select * from Bookings where Payment_Method = 'UPI';

select * from UPI_PAYMENTS;


#8. Find the average customer rating per vehicle type:

create view average_customer_rating as
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating
from bookings
GROUP BY Vehicle_Type;

select * from average_customer_rating;

#9. Calculate the total booking value of rides completed successfully:

create view total_booking_value as
SELECT SUM(Booking_Value) as ToTal_Successful_Ride_Value
from Bookings
where Booking_status = 'Success';

select * from total_booking_value;

#10. List all incomplete rides along with the reason:
create view incomplete_rides_reason as
select Booking_ID, Incomplete_Rides_Reasons
from Bookings
where Booking_status = 'Yes';

select  * from incomplete_rides_reason;




