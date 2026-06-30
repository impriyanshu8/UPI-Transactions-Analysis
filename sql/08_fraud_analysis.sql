-- Fraud By state
SELECT
sender_state,
COUNT(*) AS Fraud_Cases
FROM upi_transactions
WHERE fraud_flag=1
GROUP BY sender_state
ORDER BY Fraud_Cases DESC;

-- Fraud by bank
SELECT
sender_bank,
COUNT(*) AS Fraud_Cases
FROM upi_transactions
WHERE fraud_flag=1
GROUP BY sender_bank
ORDER BY Fraud_Cases DESC;

-- Fraud by Transaction Type
SELECT
transaction_type,
COUNT(*) AS Fraud_Cases
FROM upi_transactions
WHERE fraud_flag=1
GROUP BY transaction_type;

-- Fraud by Device
SELECT
device_type,
COUNT(*) AS Fraud_Cases
FROM upi_transactions
WHERE fraud_flag=1
GROUP BY device_type;

-- Fraud by time period 
SELECT
time_period,
COUNT(*) AS Fraud_Cases
FROM upi_transactions
WHERE fraud_flag=1
GROUP BY time_period;
