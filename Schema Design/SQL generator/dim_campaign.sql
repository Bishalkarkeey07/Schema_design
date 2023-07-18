create table if not exists dim_campaign
(
campaign_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  campaign_id  int,
   account_id  int,
  campaign_name varchar(255)
);

insert into dim_campaign (campaign_id,campaign_name)
	select distinct s.campaign_id as campaign_id ,s.campaign_name as campaign_name
 	from stage_table s
 	left join dim_campaign d on s.campaign_id = d.campaign_id
 	where d.campaign_id is null ;
    
   --  for duplicate check
SELECT campaign_key , campaign_id, COUNT(*)  as duplicate_count
FROM dim_campaign
GROUP BY campaign_key ,campaign_id
HAVING COUNT(*) > 1;

select * from dim_campaign;

INSERT INTO dim_campaign (account_id, campaign_id, campaign_name)
SELECT
    g.accountid,
    g.campaignid,
    COALESCE(t.latest_campaign_name, g.campaignname) AS campaign_name
FROM
    dim_campaign_generator AS g
LEFT JOIN
    temp AS t
    ON g.accountid = t.accountid AND g.campaignid = t.campaignid
ON DUPLICATE KEY UPDATE
    campaign_name = COALESCE(t.latest_campaign_name, g.campaignname);

