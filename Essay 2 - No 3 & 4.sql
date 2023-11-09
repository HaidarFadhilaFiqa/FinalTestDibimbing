--3. Create a fact table called fact_post_performance to store metrics like post views and likes over time
--4. Populate the fact table by joining and aggregating data from the raw tables

-- Create fact table
CREATE TABLE fact_post_performance (
    performance_id INT PRIMARY KEY,
    post_id INT,
    date_id DATE,
    views INT,
    likes INT,
    FOREIGN KEY (post_id) REFERENCES dim_post(post_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);


-- Populate fact table
INSERT INTO fact_post_performance (post_id, date_id, views, likes)
SELECT 
    rp.post_id,
    dd.date_id,
    COUNT(DISTINCT rp.user_id) AS views,
    COUNT(rl.like_id) AS likes
FROM 
    raw_posts rp
JOIN 
    dim_date dd ON rp.post_date = dd.date_id OR rl.like_date = dd.like_date
LEFT JOIN 
    raw_likes rl ON rp.post_id = rl.post_id
GROUP BY 
    rp.post_id, dd.date_id;