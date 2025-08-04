# Ola Data Analyst Project
This repository contains a comprehensive data analysis project focused on Ola Cabs' booking data for the city of Bengaluru for the month of July. The project involves data preparation, data loading, exploratory data analysis (EDA) using SQL, and the creation of an interactive dashboard in Power BI to uncover key insights into booking patterns, revenue, cancellations, and customer/driver ratings.

---
## Table of Contents

- [About the Project](#about-the-project)  
- [Dataset](#dataset)  
- [Project Workflow](#project-workflow)  
- [Tools and Technologies](#tools-and-technologies)  
- [Data Loading](#data-loading)  
- [SQL Exploratory Data Analysis (EDA)](#sql-exploratory-data-analysis-eda)  
- [Power BI Dashboard](#power-bi-dashboard)  
- [Key Insights](#key-insights)  
- [How to Reproduce](#how-to-reproduce)

---
## About the Project

The goal of this project is to analyze Ola Cabs’ **July booking data** to:
- Understand ride patterns
- Identify factors contributing to cancellations
- Evaluate revenue streams
- Assess customer/driver ratings

The insights gained aim to **optimize operations**, **enhance customer satisfaction**, and **increase revenue**.

---
## Dataset
The dataset used for this analysis is [Bookings-100000-Rows.csv](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Bookings-100000-Rows.csv), which contains over 103024 records of booking data for Bengaluru for the month of July.

## Key Columns:
- `booking_date`, `booking_time`
- `booking_id`, `customer_id`
- `booking_status` (Success, Canceled by Customer, etc.)
- `vehicle_type` (Auto, Prime Sedan, Bike, etc.)
- `pickup_location`, `drop_location`
- `booking_value`, `payment_method`
- `ride_distance`
- `driver_ratings`, `customer_rating`
- `cancellation_reason`, `incomplete_ride_reason`

---
## Project Workflow
The project follows a structured workflow:
1. **Data Preparation and Cleaning** : The initial CSV data was examined for inconsistencies, missing values, and incorrect data types to ensure data quality before analysis.
2. **Data Loading** : A **Python** script was used to read the cleaned CSV data and load it into a structured **MySQL** database for efficient querying.
3. **Exploratory Data Analysis** : SQL queries were executed to answer specific business questions, exploring relationships and patterns within the data.
4. **Dashboarding and Visualization** : An interactive dashboard was built in **Power BI** to visualize the findings from the SQL analysis and provide a clear, at-a-glance overview of key metrics.

---
## Tools and Technologies
- **Microsoft Excel** : For initial data collection, storage, and preliminary cleaning.
- **Python** : For scripting the automated data loading and transformation process.
    - **Libraries** : `pandas`, `pymysql`, `sqlalchemy`
- **MySQL** : For robust data storage and performing complex exploratory data analysis.
- **Power BI**: For creating the interactive data visualization dashboard.

---
## Data Loading
The [bookings.ipynb](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/bookings.ipynb) Jupyter Notebook contains the Python script responsible for:
1. Establishing a connection to the **MySQL server**.
2. Creating a database named `ola` and a table named `booking`.
3. Reading the [Bookings-100000-Rows.csv](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Bookings-100000-Rows.csv) file in batches.
4. Cleaning and transforming data where necessary (e.g., handling null values, converting data types).
5. Inserting the 103,024 rows of data into the `booking` table.

---
## SQL Exploratory Data Analysis (EDA)
The [`Bookings_Ola.sql`](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Bookings_Ola.sql) script contains queries to answer critical business questions. Views were created for each question to allow for easy access to the results.

**Key questions answered using SQL:**
1. How many bookings were successful?
```sql
CREATE VIEW Successfull_Bookings AS
SELECT *
FROM booking
WHERE booking_status="Success"
;
```
2. What is the average ride distance for each vehicle type?
```sql
CREATE VIEW Ride_Distance_For_Each_Vehicle AS
SELECT vehicle_type AS Vehicle, AVG(ride_distance) AS Average
FROM booking
GROUP BY 1
;
```
3. What is the total number of rides canceled by customers?
```sql
CREATE VIEW Cancelled_Rides_By_Customer AS
SELECT COUNT(*) AS Count
FROM booking
WHERE booking_status="Canceled by Customer"
;
```
4. Who are the top 5 customers by the number of rides booked?
```sql
CREATE VIEW Top_5_Customers AS
SELECT customer_id, COUNT(booking_id) as Total_Rides
FROM booking
GROUP BY 1
ORDER BY Total_Rides DESC
LIMIT 5;
```
5. How many rides were canceled by drivers for personal and car-related issues?
```sql
CREATE VIEW Rides_Cancelled_by_Driver_P_C_Issue AS
SELECT COUNT(*)
FROM booking
WHERE 
canceled_rides_by_driver='Personal & Car related issue';
```
6. What are the maximum and minimum driver ratings for Prime Sedan bookings?
```sql
CREATE VIEW Max_Min_Driver_Rating AS
SELECT 
MAX(driver_ratings) AS Maximum_Rating, MIN(driver_ratings) AS Minimum_Rating
FROM booking
WHERE 
vehicle_type='Prime Sedan';
```
7. How many rides were paid for using UPI?
```sql
CREATE VIEW UPI_Payment AS
SELECT *
FROM booking
WHERE 
payment_method='UPI';

```
8. What is the average customer rating for each vehicle type?
```sql
CREATE VIEW Average_Customer_Rating AS
SELECT vehicle_type, ROUND(AVG(customer_rating),2) AS Avg_Customer_Rating
FROM booking
GROUP BY 1;
```
9. What is the total booking value from successfully completed rides?
```sql
CREATE VIEW Total_Sucessfull_Rides_Value AS
SELECT SUM(booking_value) AS Total_Booking_Value
FROM booking
WHERE booking_status='Success';
```
10. Which rides were incomplete and for what reasons?
```sql
CREATE VIEW Incomplete_Rides_With_Reason AS
SELECT booking_id,incomplete_rides_reason
FROM booking
WHERE incomplete_rides='Yes'
;
```

---
## Power BI Dashboard
An interactive, multi-page dashboard was created in Power BI to visualize the analyzed data. The dashboard is designed to be intuitive and provides deep insights across different aspects of the business.
1. **Overall View :**
   This page gives a high-level summary of the business, showing total bookings, total booking value, a breakdown of booking statuses, and the ride volume over the month.
   
![Overall](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Screenshots/Overall.png)

2. **Vehicle Type View :** This view analyzes the performance of different vehicle categories based on total booking value, successful booking value, and distance traveled.

![Vehicle Type](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Screenshots/Vehicle%20Type.png)
   
3. **Revenue View :** This page focuses on financial metrics, breaking down revenue by payment method, identifying the top 5 customers by booking value, and showing the ride distance distribution per day.

![Revenue View](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Screenshots/Revenue.png)

4. **Cancellation View :** This view provides a detailed analysis of ride cancellations, breaking down the reasons for cancellations by both customers and drivers. This is crucial for identifying areas for operational improvement.

![Cancellation](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Screenshots/Cancellation.png)

5. **Ratings View :** This page visualizes the average customer and driver ratings for each vehicle type, helping to gauge service quality and customer satisfaction across different ride options.

![Ratings](https://github.com/Subani7181/Ola_Data_Analyst_Project/blob/main/Screenshots/Ratings.png)

---
## Key Insights

- **Booking Status: 62.09%** of all bookings were successful, with a significant portion being canceled by either the driver or the customer.
- **Revenue: Cash** is the most dominant payment method, followed by **UPI**. A small group of top customers contributes significantly to the total booking value.
- **Cancellations:** The most common reason for driver cancellations is **Personal & Car related issue (35.49%)**. For customers, the primary reason is **Driver is not moving towards pickup (30.24%)**.
- **Vehicle Performance: E-Bike** and **Prime Sedan** have the highest total booking values. **Auto** has the lowest average ride distance, indicating its use for shorter trips.
- **Ratings:** Most vehicle types maintain an average rating close to **4.0** from both customers and drivers, with **Prime SUV and E-Bike** having the highest driver ratings.

---
## How to Reproduce

1. **Prerequisites :**
    - Install Python 3.x.
    - Install MySQL Server.
    - Install Power BI Desktop.
2. **Database Setup :**
    - Create a new database in MySQL named `ola`.
    - Update the `DB_CONFIG` dictionary in the `bookings.ipynb` notebook with your MySQL credentials.
3. **Data Loading :**
    - Run the cells in the `bookings.ipynb` notebook to load the `Booking-100000-Rows.csv` data into your MySQL database.
4. **SQl Analysis :**
    - Execute the queries in `Bookings_Ola.sql` against your `ola` database to perform the EDA.
5. **Power BI Dashboard :**
    - Open the `Ola-Dashboard.pbix` file.
    - If needed, update the data source credentials to connect to your local MySQL database.

---
## Acknowledgements

This project is a personal initiative to practice and showcase skills in **Data Analytics** and **business intelligence** using a real-world transportation dataset.

---
For queries or collaborations:

- **Email**: [syedmahaboobjani772@gmail.com](mailto:syedmahaboobjani772@gmail.com)
- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/syed-mahabub-jani)

Thank you!
