create table if not exists dim_campaign_generator 
(
  campaign_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  accountid  int,
  campaignid  int,
  fdate  date,
  campaignname varchar(255)
);

INSERT INTO dim_campaign_generator  (accountid, campaignid,campaignname)
SELECT DISTINCT
    accountid,
    campaignid,
    campaignname
FROM
    temp
WHERE
    NOT EXISTS (
        SELECT 1
        FROM dim_campaign_generator 
        WHERE dim_campaign_generator .accountid = temp.accountid AND dim_campaign_generator .campaignid = temp.campaignid
    );
select * from dim_campaign_generator