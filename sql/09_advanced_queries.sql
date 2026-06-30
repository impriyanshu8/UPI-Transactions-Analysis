-- Rank Banks by transaction Volume
SELECT
    sender_bank,
    SUM(amount_INR) AS Total_Volume,
    RANK() OVER(
        ORDER BY SUM(amount_INR) DESC
    ) AS Bank_Rank
FROM upi_transactions
GROUP BY sender_bank;

-- Dense Rank States by Transaction Count
SELECT
    sender_state,
    COUNT(*) AS Transactions,
    DENSE_RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS State_Rank
FROM upi_transactions
GROUP BY sender_state;

-- Top 5 Merchant Categories
WITH MerchantRanking AS
(
SELECT
    merchant_category,
    SUM(amount_INR) AS Volume,
    RANK() OVER(
        ORDER BY SUM(amount_INR) DESC
    ) AS Ranking
FROM upi_transactions
GROUP BY merchant_category
)

SELECT *
FROM MerchantRanking
WHERE Ranking <= 5;

-- Highest Transaction in Each State

WITH RankedTransactions AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY sender_state
ORDER BY amount_INR DESC
) AS rn

FROM upi_transactions
)

SELECT
sender_state,
transaction_id,
amount_INR
FROM RankedTransactions
WHERE rn=1;

-- Running Total of Transaction Volume
SELECT
timestamp,
amount_INR,

SUM(amount_INR)
OVER(
ORDER BY timestamp
) AS Running_Total

FROM upi_transactions;

-- Percentage Contribution of Each Bank
SELECT
sender_bank,

SUM(amount_INR) AS Volume,

ROUND(

SUM(amount_INR)*100.0/

SUM(SUM(amount_INR))
OVER(),

2

) AS Percentage_Contribution

FROM upi_transactions

GROUP BY sender_bank

ORDER BY Percentage_Contribution DESC;

-- Average Transaction Compared with Overall Average
SELECT
sender_bank,

AVG(amount_INR) AS Bank_Average,

(
SELECT AVG(amount_INR)
FROM upi_transactions
) AS Overall_Average

FROM upi_transactions

GROUP BY sender_bank;

-- Banks Above Average Transaction Amount
SELECT
sender_bank,
AVG(amount_INR) AS Avg_Amount

FROM upi_transactions

GROUP BY sender_bank

HAVING AVG(amount_INR)>
(
SELECT AVG(amount_INR)
FROM upi_transactions
);

-- Categorize Transactions using CASE
SELECT

transaction_id,

amount_INR,

CASE

WHEN amount_INR<500
THEN 'Low'

WHEN amount_INR<2000
THEN 'Medium'

WHEN amount_INR<5000
THEN 'High'

ELSE 'Premium'

END AS Transaction_Category

FROM upi_transactions;

-- Fraud Percentage by State
SELECT

sender_state,

COUNT(*) AS Total_Transactions,

SUM(fraud_flag) AS Fraud_Count,

ROUND(

SUM(fraud_flag)*100.0/

COUNT(*),

2

) AS Fraud_Percentage

FROM upi_transactions

GROUP BY sender_state

ORDER BY Fraud_Percentage DESC;

-- Top 3 Banks in Every State
WITH RankedBanks AS
(
SELECT

sender_state,

sender_bank,

SUM(amount_INR) AS Volume,

ROW_NUMBER()
OVER(
PARTITION BY sender_state
ORDER BY SUM(amount_INR) DESC
) AS rn

FROM upi_transactions

GROUP BY
sender_state,
sender_bank
)

SELECT *
FROM RankedBanks

WHERE rn<=3;

-- Fraud Trend by Time Period
SELECT

time_period,

COUNT(*) AS Total_Transactions,

SUM(fraud_flag) AS Fraud_Transactions,

ROUND(

SUM(fraud_flag)*100.0/

COUNT(*),

2

) AS Fraud_Rate

FROM upi_transactions

GROUP BY time_period;

-- NTILE Analysis (Customer Segmentation)
SELECT

transaction_id,

amount_INR,

NTILE(4)
OVER(
ORDER BY amount_INR
) AS Amount_Quartile

FROM upi_transactions;

-- Previous Transaction Comparison
SELECT

transaction_id,

timestamp,

amount_INR,

LAG(amount_INR)
OVER(
ORDER BY timestamp
) AS Previous_Transaction

FROM upi_transactions;

-- Next Transaction Comparison
SELECT

transaction_id,

timestamp,

amount_INR,

LEAD(amount_INR)
OVER(
ORDER BY timestamp
) AS Next_Transaction

FROM upi_transactions;

-- Fraud Ranking By banks
SELECT

sender_bank,

SUM(fraud_flag) AS Fraud_Count,

RANK()
OVER(
ORDER BY SUM(fraud_flag) DESC
) AS Fraud_Rank

FROM upi_transactions

GROUP BY sender_bank;

-- Monthly Transaction Growth
SELECT

year,

month,

SUM(amount_INR) AS Monthly_Volume,

LAG(
SUM(amount_INR)
)
OVER(
ORDER BY year, month
) AS Previous_Month

FROM upi_transactions

GROUP BY year, month;

-- Find Banks Processing Above Overall Volume
WITH BankVolume AS
(
SELECT

sender_bank,

SUM(amount_INR) AS Volume

FROM upi_transactions

GROUP BY sender_bank
)

SELECT *

FROM BankVolume

WHERE Volume>
(
SELECT AVG(Volume)
FROM BankVolume
);

-- Highest Fraud Transaction in Each State
WITH FraudRank AS
(
SELECT *,

ROW_NUMBER()
OVER(
PARTITION BY sender_state
ORDER BY amount_INR DESC
) AS rn

FROM upi_transactions

WHERE fraud_flag=1
)

SELECT

sender_state,

transaction_id,

amount_INR

FROM FraudRank

WHERE rn=1;

-- Dashboard Summary Query
SELECT

COUNT(*) AS Total_Transactions,

SUM(amount_INR) AS Total_Volume,

AVG(amount_INR) AS Average_Transaction,

SUM(fraud_flag) AS Fraud_Count,

ROUND(
SUM(fraud_flag)*100.0/
COUNT(*),
2
) AS Fraud_Rate,

ROUND(
COUNT(
CASE
WHEN transaction_status='SUCCESS'
THEN 1
END
)*100.0/
COUNT(*),
2
) AS Success_Rate

FROM upi_transactions;