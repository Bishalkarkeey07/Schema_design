create table if not exists dim_adset_generator 
(
  adset_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  accountid  int,
  adsetid  int
);

insert into dim_adset_generator  (accountid , adsetid )
select accountid,adsetid 
from temps t
left join dim_adset_generator dcg
on t.accountid  = dcg.accountid  and t.adsetid  = dcg.adsetid 
where dcg.accountid is null;