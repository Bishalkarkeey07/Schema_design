SET SQL_SAFE_UPDATES = 0;
DELETE stage_table
FROM stage_table
JOIN temp_stage ON stage_table.account_id = temp_stage.accountid AND stage_table.date_start = temp_stage.fdate;
