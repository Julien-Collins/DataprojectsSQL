/*
What are the top skills based on salary?
- Look at the avg salary associated with each skill for data analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? Reveals how different skills impact salary levels for data analysts and most financially
  skills that there are. 
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;

/*
- Cloud & Data Science Dominance: Skills in cloud platforms 
(e.g., GCP, Kubernetes) and big data tools (Databricks, Pyspark) dominate the highest-paying roles. 
Additionally, expertise in data science technologies like Pandas, Scikit-learn, and Jupyter are 
in high demand, reflecting the growing need for data-driven decision-making.
- Programming & Automation Expertise: Proficiency in programming languages like Swift and
 Golang is highly valued for high-paying software development roles. DevOps and CI/CD tools
 such as Jenkins, GitLab, and Twilio are also critical for streamlining development and operations
 processes
 - Database & Infrastructure Knowledge: Advanced skills in database management systems
  like PostgreSQL and Couchbase, along with infrastructure tools such as Linux and Airflow,
 are essential for managing scalable systems and databases in modern tech environments. 
 */

