SELECT COUNT (DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT (DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

SELECT DISTINCT page_name
FROM page_visits;

SELECT COUNT(*) AS 'Purchasing visitors'
FROM page_visits
WHERE page_name = '4 - purchase';

WITH first_touch AS (
    SELECT user_id,
       MIN(timestamp) AS 'first_touch_at'
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
   ft.first_touch_at,
   pv.utm_source, pv.utm_campaign
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
   ON ft.user_id = pv.user_id
   AND ft.first_touch_at = pv.timestamp;
   
WITH last_touch AS (
   SELECT user_id,
      MAX(timestamp) AS 'last_touch_at'
   FROM page_visits
   GROUP BY user_id)
SELECT ft.user_id,
  ft.last_touch_at,
  pv.utm_source
FROM last_touch AS 'ft'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.last_touch_at = pv.timestamp;
  
  WITH last_touch AS (
   SELECT user_id,
      MAX(timestamp) AS 'last_touch_at'
   FROM page_visits
  WHERE page_name = '4 - purchase'
   GROUP BY user_id)
SELECT ft.user_id,
  ft.last_touch_at,
  pv.utm_source
FROM last_touch AS 'ft'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.last_touch_at = pv.timestamp;

  