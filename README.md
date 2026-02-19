# World Layoffs: Data Cleaning Project (SQL)

## Project Overview
As an EEE student bridging into Data Analytics and Edge AI, I completed this project to master the "Data Acquisition & Cleaning" phase. This project involves cleaning a messy dataset of global layoffs using MySQL.

## Skills Used
- Window Functions (`ROW_NUMBER`, `PARTITION BY`)
- Joins (Self-Joins for NULL handling)
- String Manipulation (`TRIM`, `TRAILING`)
- Data Type Transformation (`STR_TO_DATE`)

## The Cleaning Process

### 1. Removing Duplicates
I used a CTE and Window Functions to identify and remove duplicate rows.

### 2. Standardizing Data
Fixed inconsistencies in industry names and country formatting.

### 3. Handling NULL Values
Populated missing industry data by joining the table to itself based on matching company names.

---
*Special thanks to Alex The Analyst for the bootcamp guidance!*
