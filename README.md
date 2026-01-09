# SQL_Project_Data_Job_Analysis

# Intoduction
Dive into the data job market! focusing on data analyst roles, this project explores top paying jobs, in-demand skills, and where high demand meets high salary in data analystics
SQL queries? Check them out here: [project_sql folder](https://github.com/JusticeAnalyst/SQL_Project_Data_Job_Analysis/tree/main/Project%20Sql)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from my SQL Course. It's packed with insights on job titles, salaries, locations, and essential skills.

## The questions I wanted to answer through my SQL queries were:
What are the top-paying data analyst jobs?
What skills are required for these top-paying jobs?
What skills are most in demand for data analysts?
Which skills are associated with higher salaries?
What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: Served as the core analytical tool, enabling efficient data querying and extraction of key insights.
- **Git & GitHub**: Employed for version control and collaboration, allowing me to track changes and share SQL scripts and analyses effectively.
# The Analysis
Each query in this project was designed to explore a distinct dimension of the data analyst job market. I structured my analysis so that every question targeted a specific insight, allowing for a focused and systematic investigation of industry trends.

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```
SELECT	TOP 10
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
    salary_year_avg DESC;
```

Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range**: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers**: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety**: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```
WITH top_paying_jobs AS (
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
    salary_year_avg DESC;
```
Based on my SQL query and 2023 job market data, here are the key insights from the skill requirements:

The vast majority of top-paying roles (salaries often exceeding $115,000–$200,000+) require mastery of these three core tools:
- **SQL (Structured Query Language)**: The essential backbone for querying and manipulating large databases.
- **Python/R**: These programming languages are "non-negotiable" for high-paying roles because they allow for advanced statistical modeling and automation that Excel cannot handle.
- **Tableau/Power BI**: These are the primary tools used to translate complex data into actionable business dashboards.
Other skills like Snowflake, Pandas and Excel show varying degrees of demand.

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```
SELECT TOP 5
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = 1  -- (1=True)
GROUP BY
    skills
ORDER BY
    demand_count DESC;
```

Here's the breakdown of the most demanded skills for data analysts in 2023

- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```
SELECT  TOP 25
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True -- (1=True)
GROUP BY
    skills
ORDER BY
    avg_salary DESC;
```

Here are the key trends driving these top-paying salaries:

- **The "Big Data" Engineering Premium**: The highest salaries (often $150,000+) are heavily concentrated in tools that handle data at a massive scale.
Cloud Data Warehouses: Skills like Snowflake and Databricks are consistently at the top because they represent the infrastructure modern companies use to store data in the cloud.
Distributed Computing: PySpark and Spark are elite skills because they allow an analyst to process millions of rows of data simultaneously, a task traditional SQL or Excel cannot handle alone.
- **Specialized Programming vs. General Analysis**: While SQL remains the "bread and butter" of the industry, the top 25 list is dominated by specialized programming frameworks:
Beyond Basic Python: Instead of just "Python," top roles look for specific libraries like Pandas, NumPy, or scikit-learn for machine learning.
The "DevOps" Analyst: Proficiency in tools like Git or Docker is becoming a differentiator for high-paying remote roles, as it shows an analyst can work within a professional software development workflow.
-** Industry-Specific "Niche" Skills**: High-paying roles in 2023 often required "niche" technical knowledge that commands a higher market price:
Econometrics & Modeling: In finance and hedge funds, knowing Econometrics or Stata can push a salary significantly higher than a general business analyst role.
ERP & Business Systems: Deep expertise in complex business systems like SAP or Oracle remains highly rewarded because these systems are critical to large-scale corporate operations.

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id, 
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = 1
    GROUP BY 
        skills_dim.skill_id, 
        skills_dim.skills
), -- Separator for the next CTE
average_salary AS (
    SELECT 
        skills_dim.skill_id, 
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = 1 
    GROUP BY 
        skills_dim.skill_id, 
        skills_dim.skills
)

SELECT TOP 25
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
	demand_count > 10
ORDER BY 
	avg_salary DESC,
    demand_count DESC
```

Here’s a clear, polished paraphrase with a professional and analytical tone:

This analysis highlights the most in-demand and rewarding skills for Data Analysts in 2023.

- **Programming Languages**: Python and R emerge as the most sought-after languages, with demand counts of 236 and 148 respectively. While both command strong average salaries—approximately $101,397 for Python and $100,499 for R—their widespread adoption suggests these skills are highly valued yet commonly available in the market.

- **Cloud Platforms and Technologies**: Specialized tools such as Snowflake, Azure, AWS, and BigQuery demonstrate notable demand alongside higher average salaries, underscoring the increasing reliance on cloud infrastructure and big data solutions within data analytics roles.

- **Business Intelligence and Visualization Tools**: Tableau and Looker remain essential, with demand counts of 230 and 49 and average salaries near $99,288 and $103,795 respectively. This emphasizes the importance of translating data into actionable insights through effective visualization and reporting.

- **Database Technologies**: Continued demand for both traditional and NoSQL databases—including Oracle, SQL Server, and NoSQL systems—with average salaries ranging from $97,786 to $104,534 reflects the ongoing need for strong data storage, querying, and management capabilities.

# What I Learned
Throughout this project, I significantly strengthened my SQL skill set and applied it in practical, real-world scenarios:

- 🧩 **Advanced Query Development**: Gained hands-on experience writing complex SQL queries, efficiently joining multiple tables and using WITH clauses (CTEs) to manage intermediate results.

- 📊 **Data Aggregation & Summarization**: Became proficient with GROUP BY and aggregate functions such as COUNT() and AVG() to extract meaningful summaries from large datasets.

- 💡 **Analytical Problem-Solving**: Enhanced my ability to translate business questions into clear, actionable SQL queries that drive insights and decision-making.

# Conclusions

## Insights
From the analysis, several general insights emerged:

- **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
- **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
- **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
- **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
- **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

# Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.





















