INSERT INTO stage_table (date_start, adset_id,adset_name, account_id, account_name, campaign_id, campaign_name, spend,impressions, frequency, objective, platform)
SELECT date_start,  adset_id, adset_name ,account_id, account_name, campaign_id, campaign_name, spend,impressions, frequency, objective, platform
FROM raw;
