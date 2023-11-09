--1. Please create dimension tables dim_user, dim_post, and dim_date to store normalized data from the raw tables
--2. Populate the dimension tables by inserting data from the related raw tables


-- Create dim_user table
CREATE TABLE dim_user (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    country VARCHAR(50)
);

-- Insert data into dim_user table from raw_users table
INSERT INTO dim_user (user_id, user_name, country)
SELECT user_id, user_name, country
FROM raw_users;


-- Create dim_post table
CREATE TABLE dim_post (
    post_id INT PRIMARY KEY,
    post_text VARCHAR(500),
    post_date DATE,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id)
);

-- Insert data into dim_post table from raw_posts table
INSERT INTO dim_post (post_id, post_text, post_date, user_id)
SELECT post_id, post_text, post_date, user_id
FROM raw_posts;


-- Create dim_date table
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    post_date DATE,
    like_date DATE
);

-- Insert data into dim_date table from raw_posts and raw_likes tables
INSERT INTO dim_date (date_id, post_date, like_date)
SELECT DISTINCT date_id, post_date, like_date
FROM (
    SELECT post_id, post_date, NULL AS like_date
    FROM raw_posts
    UNION
    SELECT post_id, NULL AS post_date, like_date
    FROM raw_likes
) AS combined_dates;
