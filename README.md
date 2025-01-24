## Introduction
This project dives into the world of high-paying data jobs and the essential skills required to secure them. The goal is to analyze job trends in the Data Analyst field, specifically targeting remote positions, to uncover the most in-demand skills that lead to higher salaries.

SQL queries? Check them out here:  [project_sql folder](/project_sql/) 
## Background
This project aims to analyze Data Analyst job postings to answer key questions about the current landscape of high-paying data jobs. The focus is on remote positions, with the goal of identifying which skills are most in demand and associated with higher salaries. The SQL queries used in this project gather and process data from job postings, helping to uncover valuable insights for aspiring data professionals.

🧐 Key Questions Addressed:

1.) What are the top-paying Data Analyst jobs?

This question explores which job roles within the Data Analyst field offer the highest average salaries, especially for remote positions.

2.) What skills are required for these top-paying jobs?

We aim to identify the specific technical and soft skills that are most frequently requested by employers for high-paying Data Analyst roles.

3.) What skills are most in demand for Data Analysts?

By analyzing the frequency of skills mentioned in job postings, we can determine which skills are the most sought-after by employers in the industry.

4.) Which skills are most associated with higher salaries?

Using salary data from job postings, we examine which skills correlate with higher average salaries, providing insights into the most financially rewarding areas of expertise.

5.) What are the most optimal skills to learn?

Based on the analysis of job demand and salary trends, we can determine which skills are both in high demand and associated with the best financial outcomes, guiding Data Analysts toward the most valuable areas for career growth.
## Tools I Used
- SQL: This was the most utilized tool in my hunt to discover meaningful insights. I used SQL to query the database and gather critical information. 
- PostgresSQL: This was the database mangement system that I used for handling the job posting data.
- Visual Studio Code: My preferred IDE for database management and executing SQL queries. 
- Git & GitHub: Essential for version control and sharing SQL and analysis.
## The Analysis
Each query for this project aimed to investigate specific aspects of the data analyst job market. Here's how I approached it:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field. 
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:

- Wide Salary Range: Top 10 paying data analyst roles span from $184k - $650k indicating significant salary potential in the career.
- Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries. 
- Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics. 
### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing inisghts into what employers value for high-compensation roles. 
```sql
WITH top_paying_jobs AS (

SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023: 
- SQL led the way. 
- Python was closely behind.
- Tableau ranked third with other skills like R, Snowflake, and Pandas being close behind.

### 3. In-Demand Skills for Data Analysts
This query helps identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
SELECT skills,
        COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND 
        job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;

WITH remote_job_skills AS (
SELECT skill_id, COUNT(*) AS skill_count
FROM skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE job_postings.job_work_from_home = TRUE AND job_postings.job_title_short = 'Data Analyst'
GROUP BY skill_id
)

SELECT skills AS skill_name,
skills.skill_id,
skill_count
FROM remote_job_skills 
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;
```
Here's the breakdown for the most demanded skills: 
- SQL and Excel remain fundamental emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation. 
- Programming and visualization tools like Python, Tableau, and Power BI are essential, especially for data storytelling and decision support. 

| Skill      | Demand Count |
|------------|--------------|
| SQL        | 7291          |
| Excel      | 4611          |
| Python     | 4330         |
| Tableau    | 3745          |
| Power BI   | 2609          |

### 4. Skills Based on Salary
Exploring the average slaries associated with different skills revealed which skills are the highest paying.
```sql
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
```
Here's a breakdown of the top paying skills for data analysis: 
- High Demand for Big Data & ML Skills
- Software Development & Deployment Proficiency
- Cloud Computing Expertise

| Skill       | Average Salary ($) |
|-------------|--------------------|
| PySpark     | 208,172            |
| Bitbucket   | 189,155            |
| Couchbase   | 160,515            |
| Watson      | 160,515            |
| DataRobot   | 155,486            |
| GitLab      | 154,500            |
| Swift       | 153,750            |
| Jupyter     | 152,777            |
| Pandas      | 151,821            |
| Elasticsearch | 145,000          |

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
        AND job_work_from_home = TRUE 
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id, skills_dim.skills
), 
average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id
WHERE 
        demand_count > 10
ORDER BY
        demand_count DESC,
        avg_salary DESC
LIMIT 25;
```
| Skill ID | Skills      | Demand Count | Average Salary ($) |
|----------|-------------|--------------|--------------------|
| 8        | Go          | 27           | 115,320            |
| 234      | Confluence  | 11           | 114,210            |
| 97       | Hadoop      | 22           | 113,193            |
| 80       | Snowflake   | 37           | 112,948            |
| 74       | Azure       | 34           | 111,225            |
| 77       | BigQuery    | 13           | 109,654            |
| 76       | AWS         | 32           | 108,317            |
| 4        | Java        | 17           | 106,906            |
| 194      | SSIS        | 12           | 106,683            |
| 233      | Jira        | 20           | 104,918            |



## 🛠️ Skills Used on Project
Throughout this project, I applied several key skills to analyze Data Analyst job postings, extract meaningful insights, and understand the relationship between job demand, skills, and salary. Here are the three main skills I utilized:

1. Data Aggregation 📊
I used data aggregation techniques to group, summarize, and calculate metrics from job postings data. By utilizing functions like COUNT() and AVG() in SQL, I was able to aggregate information about job demand for specific skills and compute average salaries. This helped to provide a clear overview of the most requested skills and their associated salaries.

2. Creating SQL Queries 📝
A large portion of the project involved writing and optimizing SQL queries to extract relevant data from large job postings datasets. I created queries that filtered data based on specific job titles (Data Analyst) and job types (remote positions), joined multiple tables, and selected key attributes such as skill IDs, skill names, and salary details. This helped me gather and organize the data required for analysis.

3. Deriving Insights from Queries 🔍
After executing the SQL queries, I analyzed the resulting data to draw meaningful insights about the job market. This included identifying the most in-demand skills, comparing salary trends for different skill sets, and understanding the factors that contribute to higher-paying Data Analyst roles. I used these insights to answer critical questions about the data, like which skills are most valuable for securing top-paying jobs.
## Conclusion
### 📚 What I Learned - Insights

Throughout this project, I gained valuable insights into the skills and salary trends within the Data Analyst job market. By analyzing remote job postings, I learned how to identify in-demand skills and their correlation with higher salaries. Here are some key takeaways from my experience:

1. Understanding Key Data Analyst Skills 🧑‍💻
I learned that SQL, Excel, Python, Power BI, and Tableau are among the most commonly required skills for data analyst roles. Each of these skills plays a crucial part in data manipulation, visualization, and analysis. By understanding which skills are in demand, I can prioritize my learning and improve my marketability as a Data Analyst.

2. The Role of Advanced Tools and Technologies 🔧
Beyond the basics, I discovered that more specialized tools like PySpark, BigQuery, and Snowflake are highly sought after and command top salaries. These technologies are particularly valuable for handling large-scale data and performing complex analyses, making them highly relevant for advanced data professionals.

3. Salary Trends and What Drives Them 💵
By analyzing the salary data, I found that skills such as PySpark, Bitbucket, and Bitbucket are associated with some of the highest-paying roles. Interestingly, technical expertise in cloud platforms like AWS, Azure, and Google Cloud (BigQuery) also drives salary increases, indicating the growing importance of cloud technologies in data-driven industries.

4. Demand vs. Salary 📈
I gained a deeper understanding of how the demand for a particular skill correlates with salary levels. While some skills may have high demand, the correlation with salary can vary based on the complexity of the tasks associated with those skills. For example, advanced skills in machine learning and cloud computing tend to have a higher salary attachment due to their complexity.

5. Strategic Skill Development 🎯
From this project, I learned that focusing on a combination of foundational and advanced skills can lead to more lucrative opportunities. Skills like Python, SQL, and Tableau are essential for entry to mid-level roles, while more specialized skills in cloud computing, machine learning, and big data technologies are key for higher-paying, senior-level positions.

6. The Importance of Staying Up-to-Date 🔄
The landscape of data analytics is constantly evolving. The demand for new tools and technologies requires continuous learning to stay competitive. Through this project, I understood the need to regularly update my skill set to align with industry demands, ensuring long-term career growth and job security.
### Closing Thoughts
This project has been an invaluable learning experience, allowing me to apply my skills in SQL and data analysis to real-world job market trends. By analyzing remote Data Analyst roles, I was able to uncover which skills are in highest demand and correlate them with salary expectations, offering a clear roadmap for career growth. The insights gained will not only guide my own learning path but also help others make informed decisions about which skills to prioritize for future opportunities. As the data landscape continues to evolve, staying informed and adaptable will be key to success in the industry.