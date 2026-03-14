# Blinkit Products SQL Analysis

## Project Overview
This project analyzes Blinkit grocery product data using SQL. 
The goal is to explore product categories, item characteristics, 
and sales-related insights using SQL queries.

## Tools Used
- SQL Server
- GitHub

## Dataset Features
The dataset includes:

- Item Identifier
- Item Weight
- Item Fat Content
- Item Type
- Item MRP
- Outlet Size
- Outlet Location Type
- Outlet Type

## SQL Analysis Performed
1. Total number of products
2. Maximum and minimum item weight
3. Average item weight
4. Product count by fat content
5. Items with MRP greater than 200
6. Item price analysis

## Example Query
SELECT Item_Identifier, Item_Type, Item_MRP
FROM BlinkitProducts
WHERE Item_MRP > 200;
