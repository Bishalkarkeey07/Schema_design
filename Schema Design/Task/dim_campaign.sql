create table if not exists dim_campaign
(
campaign_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  campaign_id  int,
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

    
select * from dim_campaign
    