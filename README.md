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
Identified rows with identical data across all columns. Since the raw data lacked a unique ID, I used a `ROW_NUMBER` window function to flag duplicates and safely remove them.

### 2. Standardizing Data
- **Industry Names:** Consolidated variations (e.g., changing 'Crypto Currency' and 'CryptoCurrency' to just 'Crypto').
- **Country Formatting:** Fixed "United States" entries that had trailing periods.
- **Date Conversion:** Converted the `date` column from `TEXT` to `DATE` type ($YYYY-MM-DD$) to allow for time-series analysis.

### 3. Handling NULL and Blank Values
- Converted blank strings to `NULL` for consistency.
- Used a **Self-Join** to fill in missing `industry` information by looking at other rows for the same company.

### 4. Final Pruning
Removed rows where both `total_laid_off` and `percentage_laid_off` were null, as they provided no actionable data for analysis. Also dropped the helper `row_num` column used during the cleaning process.

---
*Special thanks to Alex The Analyst for the bootcamp guidance!*
