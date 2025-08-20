select * from cryptopunk_sales; ###{retrive all the data from crypopunk_sales table###



#{total number of transaction_count/ sales_count throughout the time period}:
select count(*) from cryptopunk_sales;   

#{top 5 transaction based on usd_price}:
select eth_price , usd_price , event_date , token_id , transaction_hash as event from cryptopunk_sales
order by usd_price desc limit 5 ; 


#{moving average of last 50 transaction }:
select transaction_hash as event ,usd_price, avg(usd_price) over(order by event_date rows between 49 preceding and current row) as moving_avg from cryptopunk_sales;

#{average selling price of each nft}:
select name , avg(usd_price) as average_price from cryptopunk_sales group by name order by average_price desc ;

#{total no of sales per weekday}:
select dayname(event_date)as day_of_week , count(*)as number_of_sales , avg(eth_price) as averge_eth_price from cryptopunk_sales
group by day_of_week order by number_of_sales asc ;

#{sales_summary}:
SELECT 
    CONCAT(
        name, 
        ' was sold for $', ROUND(usd_price, -3) , 
        ' to ', buyer_address, 
        ' from ', seller_address, 
        ' on ', event_date
    ) AS summary
    FROM cryptopunk_sales order by round(usd_price,-3)desc ;
    
#{view creation for purchase by wallet 0*1919db...........}:
CREATE VIEW 1919_purchases AS
SELECT *
FROM cryptopunk_sales
WHERE buyer_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';

#{histogram of eth price}/{eth price range wise number of transction/sales}:
SELECT 
    ROUND(eth_price, -2) AS eth_price_range,
    COUNT(*) AS transactions
FROM cryptopunk_sales
GROUP BY eth_price_range
ORDER BY eth_price_range;


