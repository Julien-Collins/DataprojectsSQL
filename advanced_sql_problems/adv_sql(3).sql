

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

WITH january_jobs AS ( 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;


SELECT 
    company_id,
    name AS company_name 
FROM company_dim
WHERE company_id IN (
SELECT
        company_id
FROM
        job_postings_fact
WHERE
        job_no_degree_mention = TRUE
ORDER BY
    company_id
)