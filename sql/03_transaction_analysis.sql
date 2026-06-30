use upi_analytics;

-- Transaction Type Distribution
SELECT
transaction_type,
COUNT(*) AS Total_Transactions
FROM upi_transactions
GROUP BY transaction_type
ORDER BY Total_Transactions DESC;
 
-- Merchant Category Analysis
SELECT
merchant_category,
COUNT(*) AS Transactions,
SUM(amount_INR) AS Transaction_Volume
FROM upi_transactions
GROUP BY merchant_category
ORDER BY Transaction_Volume DESC;

-- Amount Bucket Analysis
SELECT
amount_bucket,
COUNT(*) AS Transactions,
SUM(amount_INR) AS Volume
FROM upi_transactions
GROUP BY amount_bucket;
