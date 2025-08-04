SELECT *
FROM booking;
#1. Retrieve all successful bookings:

CREATE VIEW Successfull_Bookings AS
SELECT *
FROM booking
WHERE booking_status="Success"
;

#2. Find the average ride distance for each vehicle type:

CREATE VIEW Ride_Distance_For_Each_Vehicle AS
SELECT vehicle_type AS Vehicle, AVG(ride_distance) AS Average
FROM booking
GROUP BY 1
;


#3. Get the total number of cancelled rides by customers:

CREATE VIEW Cancelled_Rides_By_Customer AS
SELECT COUNT(*) AS Count
FROM booking
WHERE booking_status="Canceled by Customer"
;


#4. List the top 5 customers who booked the highest number of rides:
CREATE VIEW Top_5_Customers AS
SELECT customer_id, COUNT(booking_id) as Total_Rides
FROM booking
GROUP BY 1
ORDER BY Total_Rides DESC
LIMIT 5;


#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW Rides_Cancelled_by_Driver_P_C_Issue AS
SELECT COUNT(*)
FROM booking
WHERE 
canceled_rides_by_driver='Personal & Car related issue';


#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

CREATE VIEW Max_Min_Driver_Rating AS
SELECT 
MAX(driver_ratings) AS Maximum_Rating, MIN(driver_ratings) AS Minimum_Rating
FROM booking
WHERE 
vehicle_type='Prime Sedan';


#7. Retrieve all rides where payment was made using UPI:

CREATE VIEW UPI_Payment AS
SELECT *
FROM booking
WHERE 
payment_method='UPI';


#8. Find the average customer rating per vehicle type:

CREATE VIEW Average_Customer_Rating AS
SELECT vehicle_type, ROUND(AVG(customer_rating),2) AS Avg_Customer_Rating
FROM booking
GROUP BY 1;


#9. Calculate the total booking value of rides completed successfully:

CREATE VIEW Total_Sucessfull_Rides_Value AS
SELECT SUM(booking_value) AS Total_Booking_Value
FROM booking
WHERE booking_status='Success';


#10. List all incomplete rides along with the reason:

CREATE VIEW Incomplete_Rides_With_Reason AS
SELECT booking_id,incomplete_rides_reason
FROM booking
WHERE incomplete_rides='Yes'
;