----Youtube Creator Performance Analytics----

CREATE DATABASE YouTubeAnalyticsDB1;
USE YouTubeAnalyticsDB1;

SELECT *FROM GlobalYouTubeStatistics;

-- Total Records
SELECT COUNT(*) AS Total_Records
FROM GlobalYouTubeStatistics;
-- Business Insight: Shows the total number of YouTube channels available for analysis.


-- Check Duplicate Channel Names
SELECT Youtuber, COUNT(*) AS Channel_Count
FROM GlobalYouTubeStatistics
GROUP BY Youtuber
HAVING COUNT(*) > 1
ORDER BY Channel_Count DESC;
-- Business Insight: Identifies channels appearing multiple times and helps verify potential duplicate records.


-- Check NULL Values
SELECT
    SUM(CASE WHEN Youtuber IS NULL THEN 1 ELSE 0 END) AS Youtuber_NULL,
    SUM(CASE WHEN subscribers IS NULL THEN 1 ELSE 0 END) AS Subscribers_NULL,
    SUM(CASE WHEN video_views IS NULL THEN 1 ELSE 0 END) AS Video_Views_NULL,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS Category_NULL,
    SUM(CASE WHEN uploads IS NULL THEN 1 ELSE 0 END) AS Uploads_NULL,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_NULL,
    SUM(CASE WHEN channel_type IS NULL THEN 1 ELSE 0 END) AS Channel_Type_NULL
FROM GlobalYouTubeStatistics;
-- Business Insight: Helps identify missing information before performing business analysis.


-- Check Data Types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'GlobalYouTubeStatistics'
ORDER BY ORDINAL_POSITION;
-- Business Insight: Confirms that the imported columns have appropriate data types.

-- DATA CLEANING 
-- Replace missing categorical values

UPDATE GlobalYouTubeStatistics
SET Country = 'Unknown'
WHERE Country IS NULL;

UPDATE GlobalYouTubeStatistics
SET category = 'Unknown'
WHERE category IS NULL;

UPDATE GlobalYouTubeStatistics
SET channel_type = 'Unknown'
WHERE channel_type IS NULL;
-- Business Insight: Standardizes missing categorical values so they can be included correctly in analysis.
SELECT 
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Youtuber) AS Unique_Channels
FROM GlobalYouTubeStatistics;

--BUSINESS ANALYSIS 
-- Top 10 Channels by Subscribers

SELECT TOP 10
    Youtuber AS Channel_Name,
    Country,
    category AS Category,
    subscribers AS Subscribers
FROM GlobalYouTubeStatistics
ORDER BY subscribers DESC;
-- Business Insight: Identifies the most influential creators based on subscriber count.


-- Top 5 Countries by Total Subscribers

SELECT TOP 5
    Country,
    SUM(subscribers) AS Total_Subscribers
FROM GlobalYouTubeStatistics
GROUP BY Country
ORDER BY Total_Subscribers DESC;
-- Business Insight: Identifies the countries with the largest creator subscriber base.

-- Top 10 Categories by Video Views

SELECT TOP 10
    category AS Category,
    SUM(video_views) AS Total_Video_Views
FROM GlobalYouTubeStatistics
GROUP BY category
ORDER BY Total_Video_Views DESC;
-- Business Insight: Shows which content categories attract the highest overall audience engagement.


-- Channel with Highest Subscriber Gain in Last 30 Days

SELECT TOP 1
    Youtuber AS Channel_Name,
    subscribers_for_last_30_days AS Subscriber_Gain_Last_30_Days
FROM GlobalYouTubeStatistics
ORDER BY subscribers_for_last_30_days DESC;
-- Business Insight: Identifies the creator experiencing the strongest recent subscriber growth.


-- Average Yearly Earnings by Category

SELECT
    category AS Category,
    AVG((lowest_yearly_earnings + highest_yearly_earnings) / 2.0) AS Average_Yearly_Earnings
FROM GlobalYouTubeStatistics
GROUP BY category
ORDER BY Average_Yearly_Earnings DESC;
-- Business Insight: Highlights categories with higher estimated yearly earning potential.


-- Top 10 Channels by Video Views

SELECT TOP 10
    Youtuber AS Channel_Name,
    Country,
    category AS Category,
    video_views AS Video_Views
FROM GlobalYouTubeStatistics
ORDER BY video_views DESC;
-- Business Insight: Identifies creators with the highest accumulated content reach.


-- Top 10 Channels by Uploads

SELECT TOP 10
    Youtuber AS Channel_Name,
    uploads AS Uploads,
    subscribers AS Subscribers
FROM GlobalYouTubeStatistics
ORDER BY uploads DESC;
-- Business Insight: Identifies the most active creators based on content production volume.


-- Top 10 Countries by Video Views

SELECT TOP 10
    Country,
    SUM(video_views) AS Total_Video_Views
FROM GlobalYouTubeStatistics
GROUP BY Country
ORDER BY Total_Video_Views DESC;
-- Business Insight: Shows which countries generate the highest overall YouTube viewing activity.


-- Channel Type Analysis

SELECT
    channel_type AS Channel_Type,
    COUNT(*) AS Number_Of_Channels,
    SUM(subscribers) AS Total_Subscribers
FROM GlobalYouTubeStatistics
GROUP BY channel_type
ORDER BY Total_Subscribers DESC;
-- Business Insight: Compares channel types based on their size and overall subscriber reach.


-- Category-wise Subscriber Analysis

SELECT
    category AS Category,
    COUNT(*) AS Number_Of_Channels,
    SUM(subscribers) AS Total_Subscribers
FROM GlobalYouTubeStatistics
GROUP BY category
ORDER BY Total_Subscribers DESC;
-- Business Insight: Identifies categories with the strongest combined subscriber base.


-- Views per Subscriber

SELECT
    Youtuber AS Channel_Name,
    subscribers AS Subscribers,
    video_views AS Video_Views,
    video_views / NULLIF(subscribers,0) AS Views_Per_Subscriber
FROM GlobalYouTubeStatistics
ORDER BY Views_Per_Subscriber DESC;
-- Business Insight: Measures content reach relative to the size of a channel's subscriber base.


-- Views per Upload

SELECT
    Youtuber AS Channel_Name,
    uploads AS Uploads,
    video_views AS Video_Views,
    video_views / NULLIF(uploads,0) AS Views_Per_Upload
FROM GlobalYouTubeStatistics
WHERE uploads > 0
ORDER BY Views_Per_Upload DESC;
-- Business Insight: Identifies creators whose individual videos generate higher average reach.


-- Channels with More Than 200,000 Uploads

SELECT
    Youtuber AS Channel_Name,
    Country,
    uploads AS Uploads,
    subscribers AS Subscribers
FROM GlobalYouTubeStatistics
WHERE uploads > 200000
ORDER BY uploads DESC;
-- Business Insight: Highlights extremely high-volume creators and allows comparison between content volume and audience size.


-- Top 10 Channels by Last 30 Days Views

SELECT TOP 10
    Youtuber AS Channel_Name,
    Country,
    video_views_for_the_last_30_days AS Views_Last_30_Days
FROM GlobalYouTubeStatistics
ORDER BY Views_Last_30_Days DESC;
-- Business Insight: Identifies creators currently generating strong short-term audience activity.


-- Top 10 Categories by Estimated Earnings

SELECT TOP 10
    category AS Category,
    SUM((lowest_yearly_earnings + highest_yearly_earnings) / 2.0) AS Estimated_Total_Earnings
FROM GlobalYouTubeStatistics
GROUP BY category
ORDER BY Estimated_Total_Earnings DESC;
-- Business Insight: Identifies categories with the highest estimated overall monetization opportunity.

-- Average Subscribers by Country

SELECT
    Country,
    AVG(subscribers) AS Average_Subscribers
FROM GlobalYouTubeStatistics
GROUP BY Country
ORDER BY Average_Subscribers DESC;
-- Business Insight: Shows countries where creators have higher average audience size.


-- Average Views by Category

SELECT
    category AS Category,
    AVG(video_views) AS Average_Video_Views
FROM GlobalYouTubeStatistics
GROUP BY category
ORDER BY Average_Video_Views DESC;
-- Business Insight: Identifies categories where individual channels achieve higher average views.


-- Top 10 Channels by Recent Subscriber Growth

SELECT TOP 10
    Youtuber AS Channel_Name,
    subscribers AS Subscribers,
    subscribers_for_last_30_days AS Subscriber_Gain
FROM GlobalYouTubeStatistics
ORDER BY subscribers_for_last_30_days DESC;
-- Business Insight: Helps identify rapidly growing creators who may have strong future potential.


-- Earnings Range by Channel

SELECT TOP 10
    Youtuber AS Channel_Name,
    lowest_yearly_earnings AS Lowest_Earnings,
    highest_yearly_earnings AS Highest_Earnings
FROM GlobalYouTubeStatistics
ORDER BY highest_yearly_earnings DESC;
-- Business Insight: Highlights creators with the highest estimated upper earning potential.

CREATE VIEW vw_ChannelPerformance
AS
SELECT
    Youtuber AS Channel_Name,
    Country,
    category AS Category,
    subscribers AS Subscribers,
    video_views AS Video_Views,
    uploads AS Uploads,
    highest_yearly_earnings AS Highest_Yearly_Earnings
FROM GlobalYouTubeStatistics;


-- Check View

SELECT *
FROM vw_ChannelPerformance;
-- Business Insight: Creates a clean reusable dataset that can be directly used for Power BI reporting.


-- VIEW ANALYSIS 

SELECT TOP 10
    Channel_Name,
    Country,
    Category,
    Subscribers,
    Video_Views,
    Uploads,
    Highest_Yearly_Earnings
FROM vw_ChannelPerformance
ORDER BY Subscribers DESC;
-- Business Insight: Provides a quick performance view of the highest-subscribed creators.


-- FINAL SUMMARY

SELECT
    COUNT(*) AS Total_Channels,
    SUM(subscribers) AS Total_Subscribers,
    SUM(video_views) AS Total_Video_Views,
    SUM(uploads) AS Total_Uploads,
    AVG(subscribers) AS Average_Subscribers,
    AVG(video_views) AS Average_Video_Views
FROM GlobalYouTubeStatistics;
-- Business Insight: Provides an overall snapshot of creator population, audience size, content reach and upload activity.


