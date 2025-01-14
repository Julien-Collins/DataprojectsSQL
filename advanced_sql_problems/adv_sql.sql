WITH jan_feb_march_info AS (
SELECT
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    march_jobs
)

SELECT *
FROM jan_feb_march_info
WHERE salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;