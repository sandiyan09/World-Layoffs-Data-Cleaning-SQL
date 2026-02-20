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



## Phase 2: Exploratory Data Analysis (EDA)
In this phase, I explored the cleaned data to find trends, patterns, and outliers. This is where I applied advanced SQL techniques like CTEs and Window Functions.

### Key Insights Found:
1. **The Giants**: The biggest single layoffs came from consumer tech giants like **Amazon (18k+)**, **Google (12k)**, and **Meta (11k)**.
2. **The "Burn" Outliers**: I identified companies like **Britishvolt** ($2.4B raised) and **Quibi** ($1.8B raised) that had 100% layoffs despite massive funding.
3. **Yearly Trends**: 2022 was the peak year for layoffs in this dataset (~161,000 total), showing a massive shift in the tech economy compared to 2021.
4. **Rolling Totals**: I built a time-series query to track the "Rolling Total" of layoffs month-by-month, which is a logic I plan to apply to **Sensor Data** in my future Edge AI projects.

### Advanced Logic Used:
- **DENSE_RANK()**: To find the top 3 companies for layoffs for every single year.
- **Rolling Totals**: Using `SUM() OVER(ORDER BY...)` to see the accumulation of layoffs over time.

---
*Special thanks to Alex The Analyst for the bootcamp guidance!*
