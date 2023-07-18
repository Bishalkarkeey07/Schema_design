CREATE TABLE if not exists fact_table
(
   fdate DATE,
   adsetid BIGINT,
   adsetname varchar(255),
  accountid BIGINT,
  campaignid BIGINT,
  campaignname VARCHAR(255),
  spend BIGINT,
  impressions BIGINT,
  frequencys NUMERIC(19,2),
  objectives varchar(255),
  platforms varchar(255)
);
SET SQL_SAFE_UPDATES = 0;
DELETE fact_table
from temp_fact
-- FROM stage_table
-- JOIN fact_table ON stage_table.account_id =fact_table.accountid AND stage_table.date_start = fact_table.fdate;
JOIN fact_table ON temp_fact.accountid =fact_table.accountid AND temp_fact.fdate = fact_table.fdate;

INSERT INTO fact_table (fdate, adsetid, adsetname, accountid, campaignid, campaignname, spend, impressions, frequencys, objectives, platforms)
-- SELECT DISTINCT date_start, adset_id, adset_name, account_id, campaign_id, campaign_name, spend, impressions, frequency, objective, platform
-- FROM stage_table;
SELECT DISTINCT fdate, adsetid, adsetname, accountid, campaignid, campaignname, spend, impressions, frequency, objective, platform
from temp_fact;

select * from fact_table;

SELECT SUM(spend) AS totalspend, accountid
FROM fact_table
WHERE fdate BETWEEN '2022-10-24' AND '2023-10-28' AND accountid = 12345
GROUP BY accountid;


