DROP TABLE IF EXISTS temp_stage;
CREATE TABLE temp_stage AS
SELECT DISTINCT
  CAST(date_start AS DATE) AS fdate,
  CAST(account_id AS DECIMAL) AS accountid,
  CAST(campaign_id AS DECIMAL) AS campaignid,
  CAST(campaign_name AS char) AS campaigname,
  CAST(spend AS DECIMAL) AS spends,
  cast(impressions as decimal) as impressions,
  CAST(frequency AS DECIMAL) AS frequencys,
  cast(objective as char) as objectives,
  cast(platform as char) as platforms
FROM stage_table;

select * from temp_stage