
CREATE TABLE temps AS
SELECT account_id, adset_id, SUBSTRING_INDEX(MAX(CONCAT(date_start, ',', adset_name)), ',', 1) AS adsetname
FROM stage_table
GROUP BY account_id, adset_id;


select * from temps