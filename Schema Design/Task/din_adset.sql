create table if not exists dim_adset
(
adset_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  adset_id  int,
  adset_name varchar(255)
);

INSERT INTO dim_adset (adset_id, adset_name)
SELECT DISTINCT s.adset_id AS adset_id, s.adset_name AS adset_name
FROM stage_table s
LEFT JOIN dim_adset d ON s.adset_id = d.adset_id
WHERE d.adset_id IS NULL ;

SELECT adset_key, adset_id , COUNT(*)  as duplicate_count
FROM dim_adset
GROUP BY adset_key,adset_id
HAVING COUNT(*) > 1;

    
select * from dim_adset