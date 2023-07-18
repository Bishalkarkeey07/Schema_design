create table if not exists dim_objective
(
objective_key INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
objective varchar(255)
);

INSERT INTO dim_objective (objective)
SELECT DISTINCT s.objective as objective
FROM stage_table s
LEFT JOIN dim_objective d ON s.objective = d.objective
WHERE d.objective is  NULL ;

SELECT objective_key , COUNT(*)  as duplicate_count
FROM dim_objective
GROUP BY objective_key
HAVING COUNT(*) > 1;



select * from dim_objective