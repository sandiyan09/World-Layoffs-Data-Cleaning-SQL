CREATE SCHEMA world_layoffs;

SELECT *
FROM layoffs;

CREATE TABLE `layoffs_stagging` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT 
);


/*REMOVE DUPLICATES*/

INSERT INTO layoffs_stagging 
SELECT *,ROW_NUMBER() OVER(PARTITION BY company,location, industry,percentage_laid_off, total_laid_off,stage,country,funds_raised_millions,`date` ORDER BY industry) As row_num
FROM layoffs;

UPDATE layoffs_stagging
SET `date`= STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_stagging
MODIFY `date` DATE;

SELECT *
FROM layoffs_stagging
WHERE row_num > 1;

DELETE
FROM layoffs_stagging
WHERE row_num > 1;

/*STANDARDIZE THE DATA*/

SELECT company
FROM layoffs_stagging;

UPDATE layoffs_stagging
SET company=TRIM(company);

SELECT DISTINCT industry
FROM layoffs_stagging
ORDER BY 1;

UPDATE layoffs_stagging
SET industry ='Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_stagging
ORDER BY 1;

UPDATE layoffs_stagging
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

/*NULL VALUES AND BLANK VALUES*/

SELECT *
FROM layoffs_stagging
WHERE industry IS NULL 
OR industry ='';

SELECT *
FROM layoffs_stagging
WHERE company='Airbnb';

SELECT t1.industry,t2.industry
FROM layoffs_stagging t1
JOIN layoffs_stagging t2
	ON t1.company = t2.company
    WHERE (t1.industry IS NULL OR t1.industry = '')
    AND (t1.industry IS NOT NULL);
    
UPDATE layoffs_stagging
SET industry= NULL
WHERE industry='';
    
UPDATE layoffs_stagging t1
JOIN layoffs_stagging t2
	ON t1.company = t2.company
SET t1.industry=t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND (t2.industry IS NOT NULL);

SELECT *
FROM layoffs_stagging
WHERE (total_laid_off IS NULL OR total_laid_off ='')
AND (percentage_laid_off IS NULL OR percentage_laid_off ='');

DELETE
FROM layoffs_stagging
WHERE (total_laid_off IS NULL OR total_laid_off ='')
AND (percentage_laid_off IS NULL OR percentage_laid_off ='');

ALTER TABLE layoffs_stagging
DROP COLUMN row_num;

SELECT *
FROM layoffs_stagging;