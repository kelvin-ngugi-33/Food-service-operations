-- =====================================================
-- HOTEL FOOD SERVICE ANALYSIS QUERIES
-- =====================================================
-- Dataset: hotel_food_service
-- Purpose: Operational, customer experience, and staffing analysis
-- =====================================================


-- =====================================================
-- 1. BASIC DATA PREVIEW
-- =====================================================

SELECT
    day_of_week,
    date_time,
    channel,
    season
FROM hotel_food_service;



-- =====================================================
-- 2. AVERAGE STAFF EXPERIENCE & WAIT TIME
-- =====================================================

SELECT
    ROUND(AVG(server_experience), 1) AS avg_server_experience,
    ROUND(AVG(chef_experience), 1) AS avg_chef_experience,
    ROUND(AVG(waiting_time), 2) AS avg_waiting_time
FROM hotel_food_service;



-- =====================================================
-- 3. BUSIEST DAYS OF THE WEEK
-- =====================================================

SELECT
    day_of_week,
    COUNT(*) AS total_orders
FROM hotel_food_service
GROUP BY day_of_week
ORDER BY total_orders DESC;



-- =====================================================
-- 4. DAILY COMPLAINTS / ORDERS / RETURN INTENT
-- =====================================================

SELECT
    day_of_week,
    COUNT(*) FILTER (WHERE complaint = 'TRUE') AS complaint_count,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE complaint = 'FALSE') AS no_complaint_orders,
    COUNT(*) FILTER (WHERE return_intent = 'TRUE') AS return_intent_count
FROM hotel_food_service
GROUP BY day_of_week
ORDER BY total_orders DESC;



-- =====================================================
-- 5. TOTAL NUMBER OF COMPLAINTS
-- =====================================================

SELECT
    COUNT(*) AS total_complaints
FROM hotel_food_service
WHERE complaint = 'TRUE';



-- =====================================================
-- 6. STAFF EXPERIENCE VS COMPLAINTS
-- =====================================================

SELECT
    chef_experience,
    server_experience,
    COUNT(*) FILTER (WHERE complaint = 'TRUE') AS complaint_count
FROM hotel_food_service
GROUP BY chef_experience, server_experience
ORDER BY complaint_count DESC;



-- =====================================================
-- 7. MAXIMUM STAFF EXPERIENCE LEVELS
-- =====================================================

SELECT
    MAX(server_experience) AS max_server_experience,
    MAX(chef_experience) AS max_chef_experience
FROM hotel_food_service;



-- =====================================================
-- 8. FOOD & SERVICE QUALITY REVIEW
-- =====================================================

SELECT
    day_of_week,
    food_quality,
    service_quality,
    low_food_quality
FROM hotel_food_service;



-- =====================================================
-- 9. WAIT TIME & OPERATIONAL PRESSURE FACTORS
-- =====================================================

SELECT
    waiting_time,
    food_quality,
    low_food_quality,
    kitchen_load,
    order_complexity,
    ingredient_freshness,
    wait_issue
FROM hotel_food_service
ORDER BY waiting_time DESC;



-- =====================================================
-- 10. AVERAGE INGREDIENT FRESHNESS
-- =====================================================

SELECT
    ROUND(AVG(ingredient_freshness), 2) AS avg_ingredient_freshness
FROM hotel_food_service;



-- =====================================================
-- 11. CUISINES WITH LONGEST WAIT TIMES & MOST COMPLAINTS
-- =====================================================

SELECT
    cuisine,
    ROUND(AVG(waiting_time), 2) AS avg_wait_time,
    COUNT(*) FILTER (WHERE complaint = 'TRUE') AS complaint_count
FROM hotel_food_service
GROUP BY cuisine
ORDER BY avg_wait_time DESC, complaint_count DESC;