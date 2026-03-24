
--  HOW TO USE:
--  1. Load the CSV into a database table called `social_media`
--     (see README for instructions per database)
--  2. Run each section in order, or individually


-- 0. CREATE TABLE & LOAD DATA (SQLite example)

CREATE TABLE IF NOT EXISTS social_media (
    date             TEXT,
    platform         TEXT,
    content_type     TEXT,
    reach            INTEGER,
    likes            INTEGER,
    comments         INTEGER,
    shares           INTEGER,
    clicks           INTEGER,
    conversions      INTEGER,
    engagement       INTEGER,
    engagement_rate  REAL,
    conversion_rate  REAL,
    hour             INTEGER,
    day_of_week      TEXT,
    month            TEXT
);


-- 1. DATA OVERVIEW

-- Total number of posts
SELECT COUNT(*) AS total_posts
FROM social_media;

-- Posts per platform
SELECT
    platform,
    COUNT(*)                        AS total_posts,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM social_media), 1) AS pct_of_total
FROM social_media
GROUP BY platform
ORDER BY total_posts DESC;

-- Posts per content type
SELECT
    content_type,
    COUNT(*) AS total_posts
FROM social_media
GROUP BY content_type
ORDER BY total_posts DESC;

-- Date range of the dataset
SELECT
    MIN(date) AS earliest_post,
    MAX(date) AS latest_post
FROM social_media;


-- 2. OVERALL CAMPAIGN PERFORMANCE

SELECT
    COUNT(*)                            AS total_posts,
    SUM(reach)                          AS total_reach,
    SUM(engagement)                     AS total_engagements,
    SUM(conversions)                    AS total_conversions,
    ROUND(AVG(reach), 0)                AS avg_reach,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    ROUND(AVG(conversion_rate), 3)      AS avg_conversion_rate_pct,
    ROUND(AVG(clicks), 0)               AS avg_clicks_per_post
FROM social_media;


-- 3. PLATFORM PERFORMANCE COMPARISON

-- Core metrics per platform
SELECT
    platform,
    COUNT(*)                            AS total_posts,
    ROUND(AVG(reach), 0)                AS avg_reach,
    ROUND(AVG(likes), 0)                AS avg_likes,
    ROUND(AVG(comments), 0)             AS avg_comments,
    ROUND(AVG(shares), 0)               AS avg_shares,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    ROUND(AVG(conversion_rate), 3)      AS avg_conversion_rate_pct,
    SUM(conversions)                    AS total_conversions
FROM social_media
GROUP BY platform
ORDER BY avg_engagement_rate_pct DESC;


-- Best platform by total reach
SELECT
    platform,
    SUM(reach)                          AS total_reach,
    RANK() OVER (ORDER BY SUM(reach) DESC) AS reach_rank
FROM social_media
GROUP BY platform;


-- Platform efficiency: conversions per 1000 reach
SELECT
    platform,
    ROUND(SUM(conversions) * 1000.0 / SUM(reach), 2) AS conversions_per_1k_reach
FROM social_media
GROUP BY platform
ORDER BY conversions_per_1k_reach DESC;


-- 4. CONTENT TYPE ANALYSIS

-- Performance by content type
SELECT
    content_type,
    COUNT(*)                            AS total_posts,
    ROUND(AVG(reach), 0)                AS avg_reach,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    ROUND(AVG(conversion_rate), 3)      AS avg_conversion_rate_pct,
    SUM(conversions)                    AS total_conversions
FROM social_media
GROUP BY content_type
ORDER BY avg_engagement_rate_pct DESC;


-- Content type performance per platform (cross-tab style)
SELECT
    platform,
    content_type,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    COUNT(*)                            AS posts
FROM social_media
GROUP BY platform, content_type
ORDER BY platform, avg_engagement_rate_pct DESC;


-- Top 5 highest-performing individual posts
SELECT
    date,
    platform,
    content_type,
    reach,
    engagement,
    ROUND(engagement_rate, 2)           AS engagement_rate_pct
FROM social_media
ORDER BY engagement_rate DESC
LIMIT 5;


-- 5. BEST TIME TO POST

-- Engagement rate by hour of day
SELECT
    hour,
    COUNT(*)                            AS posts,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    ROUND(AVG(reach), 0)                AS avg_reach
FROM social_media
GROUP BY hour
ORDER BY avg_engagement_rate_pct DESC
LIMIT 10;


-- Best hour overall
SELECT
    hour                                AS best_hour,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct
FROM social_media
GROUP BY hour
ORDER BY avg_engagement_rate_pct DESC
LIMIT 1;


-- Engagement rate by day of week
SELECT
    day_of_week,
    COUNT(*)                            AS posts,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    ROUND(AVG(reach), 0)                AS avg_reach
FROM social_media
GROUP BY day_of_week
ORDER BY avg_engagement_rate_pct DESC;


-- Time bucket analysis 
SELECT
    CASE
        WHEN hour BETWEEN 0  AND 5  THEN 'Night (0-5)'
        WHEN hour BETWEEN 6  AND 11 THEN 'Morning (6-11)'
        WHEN hour BETWEEN 12 AND 17 THEN 'Afternoon (12-17)'
        WHEN hour BETWEEN 18 AND 20 THEN 'Evening (18-20)'
        ELSE                             'Late Night (21-23)'
    END                                 AS time_bucket,
    COUNT(*)                            AS posts,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    ROUND(AVG(reach), 0)                AS avg_reach
FROM social_media
GROUP BY time_bucket
ORDER BY avg_engagement_rate_pct DESC;


-- 6. MONTHLY TRENDS

-- Monthly performance over time
SELECT
    month,
    COUNT(*)                            AS total_posts,
    SUM(reach)                          AS total_reach,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    SUM(conversions)                    AS total_conversions
FROM social_media
GROUP BY month
ORDER BY month;


-- Month-over-month engagement rate change (using LAG window function)
SELECT
    month,
    ROUND(AVG(engagement_rate), 2)      AS avg_engagement_rate_pct,
    ROUND(
        AVG(engagement_rate) -
        LAG(AVG(engagement_rate)) OVER (ORDER BY month),
    2)                                  AS mom_change
FROM social_media
GROUP BY month
ORDER BY month;


-- 7. ENGAGEMENT DEEP DIVE

-- Breakdown of what drives engagement
SELECT
    platform,
    ROUND(AVG(likes), 0)                AS avg_likes,
    ROUND(AVG(comments), 0)             AS avg_comments,
    ROUND(AVG(shares), 0)               AS avg_shares,
    ROUND(AVG(likes) * 100.0 / NULLIF(AVG(engagement), 0), 1) AS likes_pct,
    ROUND(AVG(comments) * 100.0 / NULLIF(AVG(engagement), 0), 1) AS comments_pct,
    ROUND(AVG(shares) * 100.0 / NULLIF(AVG(engagement), 0), 1) AS shares_pct
FROM social_media
GROUP BY platform
ORDER BY platform;


-- High reach but low engagement
SELECT
    date,
    platform,
    content_type,
    reach,
    ROUND(engagement_rate, 2)           AS engagement_rate_pct
FROM social_media
WHERE reach > (SELECT AVG(reach) FROM social_media)
  AND engagement_rate < (SELECT AVG(engagement_rate) FROM social_media)
ORDER BY reach DESC
LIMIT 10;


-- Low reach but high engagement 
SELECT
    date,
    platform,
    content_type,
    reach,
    ROUND(engagement_rate, 2)           AS engagement_rate_pct
FROM social_media
WHERE reach < (SELECT AVG(reach) FROM social_media)
  AND engagement_rate > (SELECT AVG(engagement_rate) FROM social_media)
ORDER BY engagement_rate DESC
LIMIT 10;


-- 8. CONVERSION ANALYSIS

-- Which platform + content type combo converts best?
SELECT
    platform,
    content_type,
    ROUND(AVG(conversion_rate), 3)      AS avg_conversion_rate_pct,
    SUM(conversions)                    AS total_conversions,
    COUNT(*)                            AS posts
FROM social_media
GROUP BY platform, content_type
ORDER BY avg_conversion_rate_pct DESC
LIMIT 10;


-- Click-to-conversion rate
SELECT
    platform,
    SUM(clicks)                         AS total_clicks,
    SUM(conversions)                    AS total_conversions,
    ROUND(SUM(conversions) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS click_to_conversion_pct
FROM social_media
GROUP BY platform
ORDER BY click_to_conversion_pct DESC;


-- 9. FINAL SUMMARY VIEW

-- Executive summary — one row per platform
SELECT
    platform,
    COUNT(*)                                AS total_posts,
    SUM(reach)                              AS total_reach,
    ROUND(AVG(engagement_rate), 2)          AS avg_engagement_rate_pct,
    ROUND(AVG(conversion_rate), 3)          AS avg_conversion_rate_pct,
    SUM(conversions)                        AS total_conversions,
    ROUND(SUM(conversions) * 1000.0
          / NULLIF(SUM(reach), 0), 2)       AS conversions_per_1k_reach,
    (
        SELECT content_type
        FROM social_media s2
        WHERE s2.platform = s1.platform
        GROUP BY content_type
        ORDER BY AVG(engagement_rate) DESC
        LIMIT 1
    )                                       AS best_content_type
FROM social_media s1
GROUP BY platform
ORDER BY avg_engagement_rate_pct DESC;
