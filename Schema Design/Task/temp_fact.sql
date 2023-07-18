DROP TABLE IF EXISTS temp_fact;
CREATE TABLE temp_fact AS
SELECT
    s.date_start AS fdate,
    s.adset_id AS adsetid,
    s.adset_name AS adsetname,
    s.account_id AS accountid,
    s.campaign_id AS campaignid,
    s.campaign_name AS campaignname,
    s.spend,
    s.impressions,
    s.frequency,
    s.objective,
    s.platform
FROM
    stage_table s
LEFT JOIN
    dim_campaign c ON s.campaign_id = c.campaign_id
LEFT JOIN
    dim_adset a ON s.adset_id = a.adset_id
LEFT JOIN
    dim_platform p ON s.platform = p.platform
LEFT JOIN
    dim_objective o ON s.objective = o.objective;

    
    
select * from temp_fact
