create table if not exists dim_platform
(
platform_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
platform varchar(255)
);
INSERT INTO dim_platform ( platform)
SELECT DISTINCT s.platform as platform
FROM stage_table s
LEFT JOIN dim_platform d ON s.platform = d.platform
WHERE d.platform IS NULL ;

SELECT platform_key  , COUNT(*)  as duplicate_count
FROM dim_platform
GROUP BY platform_key 
HAVING COUNT(*) > 1;


select * from dim_platform