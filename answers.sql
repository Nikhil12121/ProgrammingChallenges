
/* 1) Write a query to get the sum of impressions by day. */
SELECT DATE(date) AS day, SUM(impressions) AS total_impressions
FROM marketing_performance
GROUP BY day
ORDER BY day;


/* 2) Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate? */
SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC 
LIMIT 3; 
/* The third best state is "OH" and the revenue it generated is "37577". */


/* 3) Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.*/
SELECT c.name AS campaign_name, 
       SUM(m.cost) AS total_cost, 
       SUM(m.impressions) AS total_impressions,
       SUM(m.clicks) AS total_clicks, 
       SUM(r.revenue) AS total_revenue
FROM campaign_info c
JOIN marketing_performance m ON c.id = m.campaign_id
JOIN website_revenue r ON c.id = r.campaign_id
GROUP BY campaign_name;


/* 4) Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?*/
SELECT w.state, SUM(m.conversions) AS total_conversions
FROM marketing_performance m
JOIN website_revenue w ON w.campaign_id = m.campaign_id
JOIN campaign_info r ON m.campaign_id = r.id
WHERE r.name = 'Campaign5'
GROUP BY w.state
ORDER BY total_conversions DESC
LIMIT 1;
/*  The state that generated the most conversions for "Campaign5" is "GA" with a total of 3342 conversions. */


/* 5) In your opinion, which campaign was the most efficient, and why?*/
SELECT c.name AS campaign_name,
       SUM(m.conversions) / SUM(m.cost) AS efficiency_ratio
FROM campaign_info c
JOIN marketing_performance m ON c.id = m.campaign_id
GROUP BY campaign_name
ORDER BY efficiency_ratio DESC
LIMIT 1;
/* In terms of efficiency, a higher efficiency ratio indicates better performance as it represents the ratio of conversions achieved to the cost incurred.
   Based on these ratios, Campaign4 appears to be the most efficient. 
   This means that for every unit of cost spent, Campaign4 is able to generate the highest number of conversions compared to the other campaigns. 
   Campaign4 is achieving more conversions per unit of cost, making it the most efficient campaign in terms of utilizing resources effectively to drive conversions.
*/


/* Bonus Question Answer */
/* 6) Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.*/
SELECT DAYNAME(date) AS day_of_week, 
       SUM(clicks) / SUM(impressions) AS click_through_rate
FROM marketing_performance
GROUP BY day_of_week
ORDER BY click_through_rate DESC
LIMIT 1;
/* 
Ads placed on Wednesdays have a higher likelihood of generating more clicks relative to the number of impressions they receive.
*/
