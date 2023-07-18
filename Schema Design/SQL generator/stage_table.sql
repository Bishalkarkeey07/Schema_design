create table if not exists stage_table
(
pri_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  date_start date,
   adset_id bigint,
   adset_name varchar(255),
  account_id bigint,
  account_name varchar(255),
  campaign_id bigint,
  campaign_name varchar(255),
  spend bigint,
  impressions bigint ,
  frequency numeric(19,4),
  objective varchar(255),
  platform varchar(255)
);
select * from stage_table