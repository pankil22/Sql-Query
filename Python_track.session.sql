CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    mgr_id INT
);

SHOW Tables;

DESCRIBE employee;

INSERT INTO employee (emp_id, first_name, last_name, mgr_id) VALUES
(1, 'Rajesh', 'Kumar', NULL),         
(2, 'Anjali', 'Sharma', 1),           
(3, 'Vikram', 'Singh', 1),            
(4, 'Sonal', 'Patel', 2),             
(5, 'Ravi', 'Deshmukh', 2),           
(6, 'Pooja', 'Mehta', 3),             
(7, 'Suresh', 'Nair', 3),             
(8, 'Deepika', 'Verma', 4),           
(9, 'Kiran', 'Jadhav', 4),            
(10, 'Manish', 'Yadav', 5);           

SELECT * FROM employee;


--Question 1 --> get all employees under each manager 

SELECT 
    m.emp_id AS manager_id,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    e.emp_id AS employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM 
    employee e
JOIN 
    employee m ON e.mgr_id = m.emp_id
ORDER BY 
    manager_id;

--Question 2 --> how many employees are there in under manager alice or any name

SELECT COUNT(*) AS employee_count
FROM employee e
JOIN employee m ON e.mgr_id = m.emp_id
WHERE CONCAT(m.first_name, ' ', m.last_name) = 'Anjali Sharma';

--Question 3 --> Get all manager details 

SELECT DISTINCT 
    m.emp_id,
    m.first_name,
    m.last_name
FROM 
    employee m
WHERE 
    m.emp_id IN (SELECT DISTINCT e.mgr_id FROM employee e WHERE e.mgr_id IS NOT NULL);

--Question 4 --> Find any employee who hasn't assigned any manager 

SELECT 
    emp_id,
    first_name,
    last_name
FROM 
    employee
WHERE 
    mgr_id IS NULL;


--Question 5 --> Write a function to get a full name(first_name+last_name)

DELIMITER $$

CREATE FUNCTION get_full_name(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END$$

DELIMITER ;


SELECT 
    emp_id,
    get_full_name(first_name, last_name) AS full_name
FROM 
    employee;







