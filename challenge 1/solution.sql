SELECT 
    c.name,
    wl.wishes->'first_choice' AS primary_wish,
    wl.wishes->'second_choice' AS backup_wish,
    wl.wishes->'colors' -> 0 AS favorite_color,
    JSON_ARRAY_LENGTH(wl.wishes->'colors') AS color_count,
    CASE
        WHEN tc.difficulty_to_make = 1 THEN 'Simple Gift'
        WHEN tc.difficulty_to_make = 2 THEN 'Moderate Gift'
        WHEN tc.difficulty_to_make >= 3 THEN 'Complex Gift'
    END AS gift_complexity,
    CASE
        WHEN tc.category = 'outdoor' THEN 'Outside Workshop'
        WHEN tc.category = 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
    END AS workshop_assignment
FROM children c
INNER JOIN wish_lists wl ON wl.child_id = c.child_id
LEFT JOIN toy_catalogue tc ON tc.toy_name = wl.wishes->>'first_choice'
ORDER BY c.name ASC
LIMIT 5;
