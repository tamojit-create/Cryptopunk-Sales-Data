# Cryptopunk-Sales-Data
📊 CryptoPunks NFT Sales Analysis
📌 Project Overview

Over the past few years, NFTs (Non-Fungible Tokens) have emerged as a groundbreaking technology on the blockchain. Among the most iconic NFT collections is CryptoPunks, which has generated millions of dollars in transactions.

This project analyzes CryptoPunks NFT sales data from Jan 2018 – Dec 2021, answering key business and technical questions using SQL queries. The analysis provides insights into transaction trends, price movements, and wallet activities.

📂 Dataset

The dataset (cryptopunkdata.csv) contains all recorded CryptoPunks sales between 2018–2021.

Columns included:

buyer_address → Wallet address of the buyer

seller_address → Wallet address of the seller

eth_price → Price of NFT in ETH

usd_price → Price of NFT in USD

date → Sale date (YYYY-MM-DD)

time → Sale time (HH:MM:SS)

nft_id → Unique NFT ID

transaction_hash → Blockchain transaction identifier

nft_name → NFT label (e.g., CryptoPunk #1139)

🎯 Objectives

Transaction Overview :

Count total sales

Find top 5 sales (by USD price)

Price Analytics:

Compute moving average of USD prices

Average NFT price per collection

Histogram of ETH price ranges

Temporal Trends:

Sales per day of the week

Monthly sales volume in USD

Most sold NFT each month/year

Wallet & Transaction Insights:

Track wallet activity (0x1919...)

Create custom purchase views

Highest vs. lowest NFT prices

Advanced Analysis:

Sale summaries in human-readable text

Estimated average daily value (excluding outliers)

📜 Key SQL Queries

Total Sales

SELECT COUNT(*) AS total_sales FROM cryptopunks_sales;


Top 5 Expensive Transactions

SELECT nft_name, eth_price, usd_price, date
FROM cryptopunks_sales
ORDER BY usd_price DESC
LIMIT 5;


Moving Average (Last 50 Transactions)

SELECT transaction_hash AS event,
       usd_price,
       AVG(usd_price) OVER (ORDER BY date, time ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) AS moving_avg_usd
FROM cryptopunks_sales;


Estimated Average Value (Outlier Removal)

-- Part A: Daily average prices
CREATE TEMPORARY TABLE daily_avg AS
SELECT date, usd_price,
       AVG(usd_price) OVER (PARTITION BY date) AS daily_avg_price
FROM cryptopunks_sales;

-- Part B: Filter outliers and compute representative value
SELECT date, AVG(usd_price) AS estimated_daily_avg
FROM daily_avg
WHERE usd_price >= 0.1 * daily_avg_price
GROUP BY date
ORDER BY date;



📈 Visualizations

Histogram of ETH Prices (rounded to nearest 100)

Monthly Sales Volume Trend

Top 5 Most Expensive Sales
