#📺 Bright TV Viewership Analysis
#🔹 Summary
#This project analyses Bright TV’s user and viewership data to uncover patterns in viewing behaviour, audience engagement, and content consumption. By integrating user demographics with viewing activity, the analysis provides meaningful insights that support data-driven decision-making for content strategy and audience targeting.
-------------------------------------------------------------------------------------------------------------------------------------------------------
🎯 Aim
The aim of this project is to:
Analyse user viewing behaviour across time, demographics, and regions
Identify the most popular channels and peak viewing periods
Understand audience engagement patterns
Provide actionable recommendations to improve viewer retention and content performance
----------------------------------------------------------------------------------------------------------------------------------------------------------
📊 Overview
The analysis is based on two datasets:
User Dataset (Bright_TV_Dataset): Contains demographic information such as gender, age, and province
Viewership Dataset (Viewer_Ship): Contains viewing activity including channel, timestamp, and duration
These datasets were joined using appropriate SQL joins to create a final enriched dataset. Data cleaning and transformation steps included:
Handling missing values (NULL and 'None')
Standardizing categorical variables (e.g., gender and province)
Converting duration into seconds for accurate aggregation
Splitting datetime into meaningful components (date, hour, time bucket, etc.)
The final dataset enabled flexible analysis through pivot tables and visualisations.
--------------------------------------------------------------------------------------------------------------------------------------------------------------
🔍 Key Insights
1. Peak Viewing Time
Viewership is highest during the evening hours, indicating that users are most active after work or school. This highlights the importance of prime-time scheduling.
2. Channel Popularity
A small number of channels account for a large portion of total watch time, suggesting that viewer preferences are concentrated around specific content providers.
3. Geographic Engagement
The Gauteng province shows the highest level of engagement compared to other regions, making it a key market for targeted strategies.
4. Demographic Trends
Viewership is not evenly distributed across demographics, with certain gender and age groups contributing more to total engagement. This indicates opportunities for more tailored content.
5. Data Gaps
A noticeable portion of the dataset contains “Unknown” demographic values, indicating missing user information and potential limitations in data collection.
------------------------------------------------------------------------------------------------------------------------------------------------------------
🚀 Strategic Recommendations
1. Optimize Content Scheduling
Since peak viewing occurs in the evening, high-value and premium content should be scheduled during this time to maximize engagement and retention.
2. Invest in High-Performing Channels
Channels with the highest total watch time should receive more investment in terms of content, partnerships, and advertising, as they drive the majority of engagement.
3. Target High-Engagement Regions
Given that Gauteng leads in viewership, marketing campaigns and infrastructure improvements should prioritise this region while also exploring ways to grow engagement in underperforming provinces.
4. Personalize Content for Demographics
Differences in engagement across gender and age groups suggest an opportunity to develop targeted content strategies that cater to specific audience segments.
5. Improve Data Collection
The presence of “Unknown” values highlights the need for improved data capture processes. Enhancing user profiling will allow for more accurate segmentation and deeper insights in future analyses.
-------------------------------------------------------------------------------------------------------------------------------------------------------------
🛠️ Tools Used
Databricks (SQL): Data cleaning, transformation, and joins
Microsoft Excel: Pivot tables and data visualisation
PowerPoint: Presentation of insights
Miro: Visualisation of the analytical workflow
--------------------------------------------------------------------------------------------------------------------------------------------------------------
✅ Final Note
This project demonstrates how combining data engineering, analysis, and visualisation techniques can transform raw data into actionable business insights that support strategic decision-making.
