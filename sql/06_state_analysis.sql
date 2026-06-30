-- Top States 
SELECT
sender_state,
COUNT(*) AS Transactions,
SUM(amount_INR) AS Volume
FROM upi_transactions
GROUP BY sender_state
ORDER BY Volume DESC;
