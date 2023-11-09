--5. Please create a fact_daily_posts table to capture the number of posts per user per day
--6. Also populate the fact table by joining and aggregating data from the raw tables

-- Create fact table
CREATE TABLE fact_daily_posts (
    daily_post_id INT PRIMARY KEY,
    user_id INT,
    date_id DATE,
    post_count INT,
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);


-- Populate fact table
INSERT INTO fact_daily_posts (user_id, date_id, post_count)
SELECT
    rp.user_id,
    dd.date_id,
    COUNT(rp.post_id) AS post_count
FROM
    raw_posts rp
JOIN
    dim_date dd ON rp.post_date = dd.date_id
GROUP BY
    rp.user_id, dd.date_id;
