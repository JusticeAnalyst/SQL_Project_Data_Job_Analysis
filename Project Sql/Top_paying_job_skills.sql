/* 
Questions: What skills are required for the top-paying data analyst jobs?
- use the top 10 highest-paying Data Analyst jobs from first query
- Add the specified skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries
*/


WITH  top_paying_jobs AS (
SELECT TOP 10
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
)

SELECT 
top_paying_jobs.*,
skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
	salary_year_avg DESC

/* 
Based on my SQL query and 2023 job market data, here are the key insights from the skill requirements:

The vast majority of top-paying roles (salaries often exceeding $115,000–$200,000+) require mastery of these three core tools:
SQL (Structured Query Language): The essential backbone for querying and manipulating large databases.
Python/R: These programming languages are "non-negotiable" for high-paying roles because they allow for advanced statistical modeling and automation that Excel cannot handle.
Tableau/Power BI: These are the primary tools used to translate complex data into actionable business dashboards.
Other skills like Snowflake, Pandas and Excel show varying degrees of demand
*/