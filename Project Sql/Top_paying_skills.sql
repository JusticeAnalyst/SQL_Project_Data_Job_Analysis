/* 
Questions: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
-Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
	helps identify the most financailly rewarding skills to acquire or improve
*/

SELECT TOP 25
	skills,
	ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
	job_title_short = 'Data Analyst' 
	AND salary_year_avg IS NOT NULL
	AND job_work_from_home = 1   -- (1 =TRUE)
GROUP BY 
	skills
ORDER BY
	avg_salary DESC
	

/*
Here are the key trends driving these top-paying salaries:

1. The "Big Data" Engineering Premium
The highest salaries (often $150,000+) are heavily concentrated in tools that handle data at a massive scale.
Cloud Data Warehouses: Skills like Snowflake and Databricks are consistently at the top because they represent the infrastructure modern companies use to store data in the cloud.
Distributed Computing: PySpark and Spark are elite skills because they allow an analyst to process millions of rows of data simultaneously, a task traditional SQL or Excel cannot handle alone.

2. Specialized Programming vs. General Analysis
While SQL remains the "bread and butter" of the industry, the top 25 list is dominated by specialized programming frameworks:
Beyond Basic Python: Instead of just "Python," top roles look for specific libraries like Pandas, NumPy, or scikit-learn for machine learning.
The "DevOps" Analyst: Proficiency in tools like Git or Docker is becoming a differentiator for high-paying remote roles, as it shows an analyst can work within a professional software development workflow.

3. Industry-Specific "Niche" Skills
High-paying roles in 2023 often required "niche" technical knowledge that commands a higher market price:
Econometrics & Modeling: In finance and hedge funds, knowing Econometrics or Stata can push a salary significantly higher than a general business analyst role.
ERP & Business Systems: Deep expertise in complex business systems like SAP or Oracle remains highly rewarded because these systems are critical to large-scale corporate operations.
*/