create database sql_project2
use sql_project2
--foreign key
alter table issued_status
add foreign key (issued_member_id)
references members(member_id);

alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);


alter table issued_status
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);
alter table issued_status
alter column issued_emp_id nvarchar(50) not null;
SELECT DISTINCT issued_emp_id
FROM issued_status
WHERE issued_emp_id NOT IN (
    SELECT emp_id
    FROM employees
);
SELECT DISTINCT emp_id
FROM employees;
SELECT DISTINCT issued_emp_id
FROM issued_status;
 ALTER TABLE issued_status
DROP COLUMN issued_emp_id;
ALTER TABLE issued_status
add issued_emp_id nvarchar(50) ;

INSERT INTO issued_status (issued_emp_id)
VALUES
('E101'),
('E102'),
('E103'),
('E104'),
('E105'),
('E106'),
('E107'),
('E108'),
('E109'),
('E110'),
('E111');

select * from issued_status;

WITH cte_new as
(
    SELECT *,
           ROW_NUMBER() OVER(ORDER BY issued_id) AS rn
    FROM issued_status
)
UPDATE cte_new
SET issued_emp_id =
    CASE ((rn - 1) % 11) + 1
        WHEN 1 THEN 'E101'
        WHEN 2 THEN 'E102'
        WHEN 3 THEN 'E103'
        WHEN 4 THEN 'E104'
        WHEN 5 THEN 'E105'
        WHEN 6 THEN 'E106'
        WHEN 7 THEN 'E107'
        WHEN 8 THEN 'E108'
        WHEN 9 THEN 'E109'
        WHEN 10 THEN 'E110'
        WHEN 11 THEN 'E111'
    END;
       
alter table employees
add constraint fk_employee
foreign key(branch_id)
references branch(branch_id);

alter table return_status
add constraint fk_return
foreign key (issued_id)
references issued_status(issued_id);

select distinct issued_id from return_status

DELETE FROM return_status
WHERE issued_id IN ('IS101','IS103','IS105');

select * from books
select * from employees
select * from branch
select * from issued_status
select * from return_status;
select * from members

alter table branch
alter Column manager_id nvarchar(50);

--task 1 cretae new book record --'978-1-60129-45-2','To kill a mockingbird','Classic',6.00,'yes','Harper Lee','J.B Lippincott'&Co.'
insert into books values('978-1-60129-45-2','To kill a mockingbird','Classic',1,'Harper Lee','J.B Lippincott & Co',6.00);

alter table books 
alter Column rental_price int ; 
 alter table  books 
 drop Column rental_price 
 alter table books 
 add rental_price int ;
  
  ALTER TABLE books
ALTER COLUMN rental_price DECIMAL(5,2);

;WITH cte AS
(
    SELECT *,
           ROW_NUMBER() OVER(ORDER BY isbn) AS rn
    FROM books
)
UPDATE cte
SET rental_price =
CASE rn
    WHEN 1 THEN 7
    WHEN 2 THEN 5.5
    WHEN 3 THEN 6.5
    WHEN 4 THEN 8
    WHEN 5 THEN 4
    WHEN 6 THEN 2.5
    WHEN 7 THEN 7
    WHEN 8 THEN 8
    WHEN 9 THEN 7.5
    WHEN 10 THEN 9
    WHEN 11 THEN 7
    WHEN 12 THEN 8
    WHEN 13 THEN 6.5
    WHEN 14 THEN 5.5
    WHEN 15 THEN 7
    WHEN 16 THEN 6.5
    WHEN 17 THEN 6.5
    WHEN 18 THEN 5
    WHEN 19 THEN 6.5
    WHEN 20 THEN 7
    WHEN 21 THEN 6
    WHEN 22 THEN 5.5
    WHEN 23 THEN 8.5
    WHEN 24 THEN 7
    WHEN 25 THEN 3.5
    WHEN 26 THEN 5.5
    WHEN 27 THEN 4
    WHEN 28 THEN 6.5
    WHEN 29 THEN 4.5
    WHEN 30 THEN 7
    WHEN 31 THEN 6.5
    WHEN 32 THEN 5
    WHEN 33 THEN 6.5
    WHEN 34 THEN 7.5
    WHEN 35 THEN 7
END;

--Task 2: Update an Existing Member's Address
update members
set member_address='420 GDk TG'
where member_id='C101';

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
delete from issued_status
where issued_id='IS121'

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
Select i.issued_book_name,e.emp_id from issued_status i 
inner join employees  e on i.issued_emp_id = e.emp_id
where i.issued_emp_id='E101'

--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
select i.issued_member_id ,count(issued_member_id)as number from issued_status i
inner join members m on i.issued_member_id=m.member_id
 group by i.issued_member_id
 having count(*)>=2
 order by number desc;
 --4. Data Analysis & Findings
--Task 7. Retrieve All Books in a Specific Category:
select distinct category from books 
select category,count(*) as no_of_books from books 
group by category 
order by no_of_books desc;

--Task 8: Find Total Rental Income by Category:
select b.category ,sum(b.rental_price ) as  total ,count(i.issued_book_isbn) as number from books b
inner join issued_status i on b.isbn=i.issued_book_isbn
group by b.category
order by total desc ;

--List Members Who Registered in the 2024:
select * from members
where year(reg_date)=2024
--List Members Who Registered in the Last 2 Years
select * from members
where reg_date>= DATEADD(year,-2,GETDATE())

--List Employees with Their Branch Manager's Name and their branch details:
select b.*,e.emp_id,e.emp_name ,m.emp_name as manager_name from employees as e
inner join branch b on e.branch_id=b.branch_id
inner join employees m on b.manager_id=m.emp_id

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
SELECT *
INTO expensive_books
FROM books
WHERE rental_price >= 6.00;
select * from expensive_books

--Task 12: Retrieve the List of Books Not Yet Returned
select * from issued_status i
where not exists  (
select r.issued_id from return_status r
where r.issued_id=i.issued_id

);
--Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

select m.member_id,m.member_name,i.issued_book_name,i.issued_date,DATEDIFF(DAY,i.issued_date,r.return_date)-30 as days_overdue from members m
inner join issued_status i on m.member_id=i.issued_member_id
inner join return_status r on i.issued_id=r.issued_id
where DATEDIFF(DAY,i.issued_date,r.return_date)>30

--Task 14: Update Book Status on Return
--Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
create Procedure get_updated
as 
begin
   update books
    set status = 1
    where isbn in(
                    select b.isbn from books b 
                    inner join return_status r on b.isbn=r.return_book_isbn
 )
end;

exec get_updated

--Task 15: Branch Performance Report
--Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals
 select * into branch_report_performance from (
  select e.branch_id,count(i.issued_emp_id)as no_of_issuedbooks,count(r.return_id)as no_of_retuned_books,sum(b.rental_price)as revenue 
from employees e
inner   join issued_status i on e.emp_id=i.issued_emp_id
left join return_status r on i.issued_id=r.issued_id
inner join books b on i.issued_book_isbn=b.isbn
group by e.branch_id) as report

select * from branch_report_performance 

--Task 16: CTAS: Create a Table of Active Members
--Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
select * into Active_members from(
select distinct issued_member_id from issued_status
where DATEDIFF(MONTH,issued_date,CURRENT_DATE)<=2
) as members 

--Task 17: Find Employees with the Most Book Issues Processed
--Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
select top 3 e.emp_id,e.emp_name,count(i.issued_id)as no_of_processed,e.branch_id from employees e 
 inner join issued_status i on e.emp_id=i.issued_emp_id
 group by e.emp_id,e.emp_name,e.branch_id
 order by no_of_processed desc;

 --Task 18: Identify Members Issuing High-Risk Books
--Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.
select m.member_name,b.book_title,count(status) as no_of_damaged_booksissued from members m
inner join issued_status i on m.member_id=i.issued_member_id
inner join books b on i.issued_book_isbn=b.isbn
where b.status='damaged'
group by  m.member_name,b.book_title
having count(*)>=2
order by no_of_damaged_booksissued desc;
--actually for this task status is bit so i just want explore the query thats it not generate the ouput 
--Task 19: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. The procedure should first check if the book is available (status = 'yes'). If the book is available, it should be issued, and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
ALTER PROCEDURE  get_data_new
    @book_id NVARCHAR(100)
AS
BEGIN
    DECLARE @status BIT;

    PRINT @book_id;

    SELECT @status = status
    FROM books
    WHERE isbn = @book_id;

    PRINT @status;

    IF @status = 1
    BEGIN
        UPDATE books
        SET status = 0
        WHERE isbn = @book_id;

        PRINT 'book is issued successfully';
    END
    ELSE
    BEGIN
        PRINT 'book is not available';
    END
END;

 exec get_data_new '978-0-14-143951-8';

 select * from books 
 where isbn='978-0-14-143951-8';
--Task 20: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

--Description: Write a CTAS query to create a  new table that lists each member and the books they have issued but not returned within 30 days. The table should include: The number of overdue books. The total fines, with each day's fine calculated at $0.50. The number of books issued by each member. The resulting table should show: Member ID Number of overdue books Total fines
select * into overdues from (
select i.issued_member_id,count(*)as over_due_books ,sum((DATEDIFF(DAY,i.issued_date,r.return_date)-30)*0.5) as over_due_amount from issued_status i 
left join return_status r on i.issued_id=r.issued_id
where DATEDIFF(DAY,i.issued_date,r.return_date)>30
group by i.issued_member_id
) as report 

select * from overdues
order by over_due_amount desc ;


select * from issued_status i 
where i.issued_id not in (
     select r.issued_id from return_status r 
     
) 
-- for the books not yet returned so i calculated the amount for current date 
SELECT
    issued_member_id,
    issued_book_name,
    issued_date,
    (DATEDIFF(DAY, issued_date, GETDATE()) - 30) * 0.5 AS fine_amount
FROM issued_status i
WHERE i.issued_id NOT IN
(
    SELECT issued_id
    FROM return_status
)
AND DATEDIFF(DAY, issued_date, GETDATE()) > 30;







