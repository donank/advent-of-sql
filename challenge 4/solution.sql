WITH unchanged_tags_table AS
(
    SELECT toy_id, toy_name, value_repeated AS unchanged_tags
    FROM toy_production
         , unnest(previous_tags || new_tags) value_repeated
    GROUP BY toy_id, toy_name, value_repeated
    HAVING count(*) > 1
    ORDER BY value_repeated
), added_tags_table AS
(
    SELECT toy_id, toy_name, value_not_repeated AS added_tags
    FROM toy_production
         , unnest(previous_tags || new_tags || new_tags) value_not_repeated
    GROUP BY toy_id, toy_name, value_not_repeated
    HAVING count(*) = 2
    ORDER BY value_not_repeated
), removed_tags_table AS
(
    SELECT toy_id, toy_name, value_removed AS removed_tags
    FROM toy_production
         , unnest(new_tags || previous_tags || new_tags) value_removed
    GROUP BY toy_id, toy_name, value_removed
    HAVING count(*) = 1
    ORDER BY value_removed
), combined_table AS
(
    SELECT utt.toy_id as toy_id,
        utt.toy_name AS toy_name,
        utt.unchanged_tags AS unchanged_tags,
        att.added_tags AS added_tags,
        rtt.removed_tags AS removed_tags
    FROM unchanged_tags_table utt
    LEFT JOIN added_tags_table att
    ON utt.toy_id = att.toy_id
    LEFT JOIN removed_tags_table rtt
    ON utt.toy_id = rtt.toy_id
)
SELECT tp.toy_id,
    tp.toy_name,
    STRING_TO_ARRAY(
        COALESCE(STRING_AGG(DISTINCT added_tags, ','), '0'), ',')
    AS added_tags,
    STRING_TO_ARRAY(
        COALESCE(STRING_AGG(DISTINCT unchanged_tags, ','), '0'), ',')
    AS unchanged_tags,
    STRING_TO_ARRAY(
        COALESCE(STRING_AGG(DISTINCT removed_tags, ','), '0'), ',')
    AS removed_tags
FROM combined_table ct
RIGHT JOIN toy_production tp
ON tp.toy_id = ct.toy_id
GROUP BY tp.toy_id, tp.toy_name
ORDER BY COALESCE
(
    ARRAY_LENGTH
    (
        STRING_TO_ARRAY(
            STRING_AGG(DISTINCT added_tags, ','),
        ','), 1
    ),
0) DESC

