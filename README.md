📚 Library Management System | SQL Server
Project Overview

This project demonstrates the design and implementation of a Library Management System using Microsoft SQL Server.

The objective of this project was not only to write SQL queries but also to understand how real-world databases are designed, maintained, and analyzed. The project includes database creation, relationship management, data integrity enforcement, reporting, stored procedures, and business analysis.

During development, I worked extensively with Primary Keys, Foreign Keys, data validation, referential integrity, joins, subqueries, stored procedures, and reporting queries.

🎯 Project Objectives
Design a relational database for a library management system.
Create and manage relationships between multiple tables.
Implement Primary Key and Foreign Key constraints.
Perform CRUD operations.
Generate business reports using SQL.
Create stored procedures to automate operations.
Analyze library activities through SQL queries.
Calculate overdue books and fine amounts.
🗄️ Database Structure

The system consists of six interconnected tables:

Branch

Stores branch information and branch managers.

Employees

Stores employee information and branch assignments.

Members

Stores member registration details.

Books

Stores book information, categories, rental prices, and availability status.

Issued_Status

Tracks all issued books.

Return_Status

Tracks all returned books.

🔗 Database Relationships

The following relationships were implemented using Foreign Keys:

Members → Issued_Status
Books → Issued_Status
Employees → Issued_Status
Branch → Employees
Issued_Status → Return_Status

These relationships ensure data consistency and prevent invalid records from being inserted into the system.

🛠️ Challenges Solved

One of the most valuable parts of this project was resolving real-world database issues:

Foreign Key constraint conflicts
Data type mismatches between related columns
Invalid reference records
Referential integrity violations
Updating existing data to satisfy relationships
Converting PostgreSQL queries into SQL Server syntax
Handling NULL values and missing references

These challenges helped me understand how relational databases work beyond writing simple SQL queries.

📊 Business Problems Solved

The project includes solutions for various business scenarios:

Member Analysis
Members who issued multiple books
Active members in recent months
Member registration analysis
Employee Analysis
Books issued by employees
Top-performing employees based on processed issues
Employee and branch reporting
Book Analysis
Books not yet returned
High-demand books
High-risk book analysis
Expensive book identification
Branch Performance Reporting

Generated branch-level reports containing:

Number of books issued
Number of books returned
Revenue generated from book rentals
Overdue Book Tracking
Identified overdue books
Calculated overdue duration
Calculated fine amounts
Identified books not returned and estimated fines using current date
⚙️ SQL Concepts Used
Joins
INNER JOIN
LEFT JOIN
SELF JOIN
Aggregations
COUNT()
SUM()
AVG()
Filtering
WHERE
HAVING
Advanced SQL
Subqueries
Common Table Expressions (CTEs)
NOT EXISTS
SELECT INTO
Database Objects
Stored Procedures
Primary Keys
Foreign Keys
Date Functions
GETDATE()
DATEDIFF()
DATEADD()
🚀 Stored Procedures Implemented
Book Return Automation

Created a stored procedure to automatically update book availability when a book is returned.

Book Issue Management

Created a parameterized stored procedure that:

Accepts a Book ISBN as input.
Checks book availability.
Issues the book if available.
Prevents issuing unavailable books.
Displays appropriate messages to users.
📈 Reports Generated
Branch Performance Report

Contains:

Total books issued
Total books returned
Revenue generated
Active Members Report

Contains members who have issued books within the last two months.

Overdue Fine Report

Contains:

Member ID
Number of overdue books
Total overdue fine amount
💡 Key Learnings

Through this project, I gained hands-on experience in:

Relational Database Design
SQL Server Administration Fundamentals
Data Integrity Management
Foreign Key Relationship Design
Query Optimization
Business-Oriented SQL Problem Solving
Stored Procedure Development
Reporting and Analytics

Most importantly, this project helped me understand that SQL is not only about writing queries but also about designing reliable database systems and solving business problems using data.

🧰 Technologies Used
Microsoft SQL Server
SQL Server Management Studio (SSMS)

👨‍💻 Author

Kruthik Teliseeri

Aspiring Data Analyst | SQL Server | Power BI | Python | Machine Learning

This project was completed independently to strengthen SQL Server, database design, reporting, and business-oriented problem-solving skills.
