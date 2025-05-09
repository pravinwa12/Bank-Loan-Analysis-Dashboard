
--Show all Inserted data
SELECT * FROM [dbo].[Bank_loan_data];

--Show count of all loan applications
SELECT COUNT(id) AS "Total Applcations" FROM Bank_loan_data;

-- Month to date(MTD) Total Loan Applications
SELECT COUNT(id) AS "MTD Total Applications" FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Previous Month to date(PMTD) Total Loan Applications
SELECT COUNT(id) AS "PMTD Total Applications" FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;
----------------------

--Calculate Total Funded Amount
SELECT SUM(loan_amount) AS "Total Funded Amount" FROM Bank_loan_data;

--Calculate MTD Total Funded Amount
SELECT SUM(loan_amount) AS "MTD Total Funded Amount" FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Calculate PMTD Total Funded Amount
SELECT SUM(loan_amount) AS "PMTD Total Funded Amount" FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;
----------------------

-- Calculate Total Amount Received
SELECT SUM(total_payment) AS "Total amount_received" FROM Bank_loan_data;

-- Calculate MTD Total Amount Received
SELECT SUM(total_payment) AS "MTD Total amount_received" FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Calculate PMTD Total Amount Received
SELECT SUM(total_payment) AS "PMTD Total amount_received" FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;
----------------------

--Calculate Avg Interset rate
--Use ROUND() for no. of Digits
SELECT ROUND(AVG(int_rate),4) * 100 AS "Avg_Interest_Rate" FROM Bank_loan_data;

--Calculate MTD Avg Interset rate
SELECT ROUND(AVG(int_rate),4) * 100 AS "MTD Avg_Interest_Rate" FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--Calculate PMTD Avg Interset rate
SELECT ROUND(AVG(int_rate),4) * 100 AS "PMTD Avg_Interest_Rate" FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;
----------------------

-- Calculate Avg DTI
SELECT ROUND(AVG(dti),4) * 100 AS Avg_DTI FROM Bank_loan_data;

-- Calculate MTD Avg DTI
SELECT ROUND(AVG(dti),4) * 100 AS MTD_Avg_DTI FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Calculate PMTD Avg DTI
SELECT ROUND(AVG(dti),4) * 100 AS PMTD_Avg_DTI FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;
----------------------

-- Good loan Percentage
SELECT
	(COUNT(CASE WHEN loan_status = 'Fully_Paid' OR loan_status = 'Current' THEN id END) * 100.0)
	/ 
	COUNT(id) AS Good_loan_percentage
FROM Bank_loan_data;

--Good Loan Applications
SELECT COUNT(id) AS Good_loan_applications FROM Bank_loan_data
WHERE loan_status = 'Fully_Paid' OR loan_status = 'Current' ;

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_funded_amount FROM Bank_loan_data
WHERE loan_status = 'Fully_Paid' OR loan_status = 'Current';

-- Good Loan Received Amount
SELECT SUM(total_payment) AS Good_Loan_received_amount FROM Bank_loan_data
WHERE loan_status = 'Fully_Paid' OR loan_status = 'Current';
----------------------

--Bad loan Percentage
SELECT
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
	/ 
	COUNT(id) AS Bad_loan_percentage
FROM Bank_loan_data;

--Bad Loan Applications
SELECT COUNT(id) AS Bad_loan_applications FROM Bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_funded_amount FROM Bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Received Amount
SELECT SUM(total_payment) AS Bad_Loan_received_amount FROM Bank_loan_data
WHERE loan_status = 'Charged Off';
----------------------

-- Loan Status
SELECT 
		loan_status,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount,
		AVG(int_rate * 100) AS Interest_Rate,
		AVG(dti * 100) AS DTI
	FROM 
		Bank_loan_data
	GROUP BY
	    loan_status;

-- MTD Loan Status
SELECT 
		loan_status,
		SUM(total_payment) AS MTD_Total_Amount_Received,
		SUM(loan_amount) AS MTD_Total_Funded_Amount
	FROM
		Bank_loan_data
	WHERE 
		MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
	GROUP BY
		loan_status;

-- PMTD Loan Status
SELECT 
		loan_status,
		SUM(total_payment) AS PMTD_Total_Amount_Received,
		SUM(loan_amount) AS PMTD_Total_Funded_Amount
	FROM
		Bank_loan_data
	WHERE 
		MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
	GROUP BY
		loan_status;
----------------------

-- Monthly Trends
SELECT 
		MONTH(issue_date) AS Month_Number,
		DATENAME(MONTH, issue_date) AS Month_Name,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM 
		Bank_loan_data
	GROUP BY
	    MONTH(issue_date),DATENAME(MONTH, issue_date) 

	ORDER BY 
		MONTH(issue_date);
----------------------

-- Status by Sate
SELECT 
		address_state,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM 
		Bank_loan_data
	GROUP BY
		address_state
	ORDER BY 
		SUM(total_payment) DESC;
----------------------

-- Status by term
SELECT 
		term,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM 
		Bank_loan_data
	GROUP BY
		term
	ORDER BY 
		term;
----------------------

-- Status by Emp_Length
SELECT 
		emp_length,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM 
		Bank_loan_data
	GROUP BY
		emp_length
	ORDER BY 
		emp_length;
----------------------

-- Status by Purpose
SELECT 
		purpose,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM 
		Bank_loan_data
	GROUP BY
		purpose
	ORDER BY 
		COUNT(id) DESC;
----------------------

-- Status by Home Ownership
SELECT 
		home_ownership,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM 
		Bank_loan_data
	GROUP BY
		home_ownership
	ORDER BY 
		COUNT(id) DESC;
----------------------

-- Status by Home Ownership
SELECT 
		home_ownership,
		COUNT(id) AS Total_loan_application,
		SUM(total_payment) AS Total_Amount_Received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM 
		Bank_loan_data
	GROUP BY
		home_ownership
	ORDER BY 
		COUNT(id) DESC;
----------------------