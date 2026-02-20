SELECT *
FROM layoffs_stagging;

SELECT MAX(total_laid_off)
FROM layoffs_stagging;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_stagging
WHERE total_laid_off IS NOT NULL;

SELECT *
FROM layoffs_stagging
WHERE percentage_laid_off = 1;

SELECT *
FROM layoffs_stagging
WHERE percentage_laid_off=1 AND funds_raised_millions IS NOT NULL
ORDER BY funds_raised_millions DESC;

SELECT company,total_laid_off
FROM layoffs_stagging
ORDER BY 2 DESC
LIMIT 5;

SELECT company,SUM(total_laid_off)
FROM layoffs_stagging
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

SELECT location,MAX(total_laid_off)
FROM layoffs_stagging
WHERE location IS NOT NULL
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

SELECT country,MAX(total_laid_off)
FROM layoffs_stagging
WHERE country IS NOT NULL
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_stagging WHERE YEAR(`date`) IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY 1 ASC;


SELECT industry,SUM(total_laid_off)
FROM layoffs_stagging WHERE industry IS NOT NULL
GROUP BY industry
ORDER BY 2 DESC;


SELECT STAGE,SUM(total_laid_off)
FROM layoffs_stagging WHERE industry IS NOT NULL
GROUP BY stage
ORDER BY 2 DESC;

WITH company_year As
(
SELECT company,YEAR(`date`) As years,SUM(total_laid_off) As total_laid_off
FROM layoffs_stagging WHERE YEAR(`date`) IS NOT NULL
GROUP BY company,YEAR(`date`)
),
company_rank As
(
SELECT company,years,total_laid_off,DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) As ranking
FROM company_year 
)
SELECT company,years,total_laid_off,ranking
FROM company_rank
WHERE ranking <=3
ORDER BY years ASC, total_laid_off DESC;

WITH date_cte As
(
SELECT SUBSTRING(`date`,1,7) As dates,SUM(total_laid_off) As total_laid_off
FROM layoffs_stagging WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates,SUM(total_laid_off) OVER(ORDER BY dates ASC) as rolling_total
FROM date_cte
ORDER BY dates ASC;





