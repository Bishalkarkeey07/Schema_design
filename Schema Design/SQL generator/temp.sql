CREATE TABLE IF NOT EXISTS temp (
  campaign_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  accountid  INT,
  campaignid  INT,
  fdate  DATE,
  campaignname VARCHAR(255),
  latest_campaign_name VARCHAR(255)
);

INSERT INTO temp (accountid, campaignid, fdate, campaignname, latest_campaign_name)
SELECT
    s.account_id AS accountid,
    s.campaign_id AS campaignid,
    s.date_start AS fdate,
    s.campaign_name AS campaignname,
    SUBSTRING_INDEX(MAX(CONCAT(s.date_start, ',', s.campaign_name)), ',', -1) AS latest_campaign_name
FROM
    stage_table s
LEFT JOIN
    temp t ON s.campaign_id = t.campaignid AND s.account_id = t.accountid
WHERE
    t.campaignid IS NULL AND t.accountid IS NULL
GROUP BY
    s.account_id, s.campaign_id, s.date_start, s.campaign_name;
    
select * from temp

