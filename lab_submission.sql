-- (i) A Procedure called PROC_LAB5
DELIMITER $$

CREATE PROCEDURE PROC_LAB5()
BEGIN
    SELECT 
        p.projectID AS 'Project ID',
        p.projectName AS 'Project Name',
        d.departmentName AS 'Department',
        COUNT(e.employeeID) AS 'Number of Employees'
    FROM 
        projects p
    JOIN 
        departments d ON p.departmentID = d.departmentID
    LEFT JOIN 
        employee_projects ep ON p.projectID = ep.projectID
    LEFT JOIN 
        employees e ON ep.employeeID = e.employeeID
    GROUP BY 
        p.projectID, p.projectName, d.departmentName
    ORDER BY 
        p.projectID;
END$$

DELIMITER ;



-- (ii) A Function called FUNC_LAB5
DELIMITER $$

CREATE FUNCTION FUNC_LAB5(deptID INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE avgDuration DECIMAL(10,2);

    SELECT 
        AVG(DATEDIFF(p.endDate, p.startDate)) 
    INTO 
        avgDuration
    FROM 
        projects p
    WHERE 
        p.departmentID = deptID;

    RETURN avgDuration;
END$$

DELIMITER ;



-- (iii) A View called VIEW_LAB5
CREATE VIEW VIEW_LAB5 AS
SELECT 
    d.departmentName AS 'Department Name',
    COUNT(e.employeeID) AS 'Total Employees',
    SUM(p.budget) AS 'Total Project Budget'
FROM 
    departments d
LEFT JOIN 
    employees e ON d.departmentID = e.departmentID
LEFT JOIN 
    projects p ON d.departmentID = p.departmentID
GROUP BY 
    d.departmentName;
