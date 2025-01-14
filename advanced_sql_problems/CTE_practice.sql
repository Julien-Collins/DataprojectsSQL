--CTE practice
WITH company_job_count AS (
SELECT 
    company_id,
    COUNT(*) AS total_jobs
FROM  
    job_postings_fact
GROUP BY
    company_id
)

SELECT company_dim.name AS company_name, 
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC


--find the top 5 skills and merge the skills_job_dim and skills_dim tables to ensure all ID's are accounted for
WITH top_skills AS (
SELECT skill_id, COUNT(skill_id) AS skill_count
FROM skills_job_dim
GROUP BY skill_id
)

SELECT skills_dim.skills AS top_skills_name,
        top_skills.skill_count
FROM skills_dim
LEFT JOIN top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC
LIMIT 5;

