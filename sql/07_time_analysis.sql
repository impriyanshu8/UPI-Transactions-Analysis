-- Peak Hours
SELECT
hour,
COUNT(*) AS Transactions
FROM upi_transactions
GROUP BY hour
ORDER BY hour;

-- Weekday Analysis
SELECT
weekday,
COUNT(*) AS Transactions
FROM upi_transactions
GROUP BY weekday;

-- Weekend Analysis

SELECT
CASE
WHEN is_weekend=1 THEN 'Weekend'
ELSE 'Weekday'
END AS Day_Type,
COUNT(*) AS Transactions,
SUM(amount_INR) AS Volume
FROM upi_transactions
GROUP BY is_weekend;