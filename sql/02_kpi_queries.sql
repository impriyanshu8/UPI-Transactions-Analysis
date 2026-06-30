select count(*) as total_transactions 
from upi_transactions;

select
sum(amount_INR) as total_transactions_volume
FROM upi_transactions;

SELECT
ROUND(AVG(amount_INR),2) AS Average_Transaction
FROM upi_transactions;

SELECT
MAX(amount_INR) AS Maximum_Transaction,
MIN(amount_INR) AS Minimum_Transaction
FROM upi_transactions;

SELECT
ROUND(
COUNT(CASE WHEN transaction_status='SUCCESS' THEN 1 END)*100.0/
COUNT(*),
2
) AS Success_Rate
FROM upi_transactions;

SELECT
ROUND(
SUM(fraud_flag)*100.0/
COUNT(*),
2
) AS Fraud_Rate
FROM upi_transactions;


