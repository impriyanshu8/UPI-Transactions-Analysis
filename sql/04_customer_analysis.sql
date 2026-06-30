-- Age Group Analysis
SELECT
sender_age_group,
COUNT(*) AS Transactions,
ROUND(AVG(amount_INR),2) AS Avg_Amount
FROM upi_transactions
GROUP BY sender_age_group
ORDER BY Transactions DESC;

-- Device Analysis
SELECT
device_type,
COUNT(*) AS Users
FROM upi_transactions
GROUP BY device_type;

-- Network Analysis
SELECT
network_type,
COUNT(*) AS Transactions
FROM upi_transactions
GROUP BY network_type;
