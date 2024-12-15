WITH original_table AS
(
    SELECT * FROM toy_production
)
SELECT tp.production_date,
    tp.toys_produced,
    COALESCE(ot.toys_produced, 0) AS previous_day_production,
    tp.toys_produced - COALESCE(ot.toys_produced, 0) AS production_change,
    (tp.toys_produced - COALESCE(ot.toys_produced, 0))::decimal/tp.toys_produced::decimal * 100
         AS production_change_percentage
FROM toy_production tp 
INNER JOIN original_table ot 
ON tp.production_date = ot.production_date + 1
ORDER BY production_change_percentage DESC
LIMIT 1
