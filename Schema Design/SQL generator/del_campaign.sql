SET SQL_SAFE_UPDATES = 0;
DELETE dc
FROM dim_campaign dc
JOIN stage_table s ON dc. account_id = s. account_id  AND dc.campaign_id = s.campaign_id;
