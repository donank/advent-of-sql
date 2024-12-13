WITH food_list_table AS
(
    SELECT 
        UNNEST(
            STRING_TO_ARRAY(
                STRING_AGG(
                    ARRAY_TO_STRING(food_ids, ',', '*'),
                ','),
            ',') 
        ) AS food_id_list
    FROM
    (
        SELECT 
            xpath('//food_item_id/text()', cm.menu_data)::text[1] AS food_ids,
            CONCAT(
                ARRAY_TO_STRING(xpath('//total_present/text()', cm.menu_data)::text[1], ',', '*'),
                ARRAY_TO_STRING(xpath('//total_count/text()', cm.menu_data)::text[1], ',', '*'),
                ARRAY_TO_STRING(xpath('//total_guests/text()', cm.menu_data)::text[1], ',', '*')
            ) AS customer_count
        FROM christmas_menus cm
    )
    WHERE customer_count::integer > 78
)
SELECT mode() WITHIN GROUP ( ORDER BY food_id_list )
FROM food_list_table;