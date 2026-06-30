-- Top Banks
SELECT
sender_bank,
COUNT(*) AS Transactions,
SUM(amount_INR) AS Volume
FROM upi_transactions
GROUP BY sender_bank
ORDER BY Volume DESC;

-- Receiver Banks
SELECT
receiver_bank,
COUNT(*) AS Transactions
FROM upi_transactions
GROUP BY receiver_bank
ORDER BY Transactions DESC;