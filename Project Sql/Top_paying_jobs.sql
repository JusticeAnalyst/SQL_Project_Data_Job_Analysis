/* 
Questions: What are the top_paying data analyst jobs?
- Identify the top 10 highest_paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remote nulls).
- Why? Highest the top_paying opportunties for Data Analytics, offering insights into employment
*/

SELECT TOP 10
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	CAST(job_posted_date AS DATE) AS job_date,
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
