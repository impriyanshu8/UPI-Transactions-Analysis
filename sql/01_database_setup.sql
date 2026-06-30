CREATE DATABASE upi_analytics;
USE upi_analytics;


CREATE TABLE upi_transactions (
    transaction_id VARCHAR(25) PRIMARY KEY,
    timestamp DATETIME,
    transaction_type VARCHAR(50),
    merchant_category VARCHAR(50),
    amount_INR DECIMAL(10,2),
    transaction_status VARCHAR(20),
    sender_age_group VARCHAR(20),
    receiver_age_group VARCHAR(20),
    sender_state VARCHAR(50),
    sender_bank VARCHAR(50),
    receiver_bank VARCHAR(50),
    device_type VARCHAR(20),
    network_type VARCHAR(20),
    fraud_flag TINYINT,
    hour_of_day INT,
    day_of_week VARCHAR(20),
    is_weekend TINYINT,

    -- Feature Engineered Columns
    year INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    hour INT,
    weekday VARCHAR(20),
    amount_bucket VARCHAR(20),
    fraud_amount DECIMAL(10,2),
    time_period VARCHAR(20)
);

select * from upi_transactions;
