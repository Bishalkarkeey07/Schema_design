create table if not exists dim_adset
(
   adset_key int,
  accountid  int,
  adsetid  int,
  adsetname varchar(255)
);

SET SQL_SAFE_UPDATES = 0;
DELETE dim_adset
FROM dim_adset
JOIN temps t ON dim_adset.accountid = t.account_id AND dim_adset.adsetid = t.adset_id;


insert into dim_adset ( adset_key,accountid, adsetid , adsetname )
select dcg.adset_key, t.account_id, t.adset_id , t.adsetname 
from temps t
inner join dim_adset_generator  dcg
on t.account_id = dcg.accountid
 and t.adset_id = dcg.adsetid;
 
 
select * from dim_adset