WITH letters_union AS 
(
    SELECT la.value FROM letters_a la
    UNION ALL
    SELECT lb.value FROM letters_b lb
), aggregated_string AS 
(
    SELECT STRING_AGG(CHR(lu.value),'') 
    FROM letters_union lu
    WHERE CHR(lu.value) ~* '^.*[A-Za-z].*$'
    OR CHR(lu.value) ~* ' '
    OR CHR(lu.value) ~* '^.*\..*$'
    OR CHR(lu.value) ~* '!'
    OR CHR(lu.value) ~* ','
    OR CHR(lu.value) ~* '-'
    OR CHR(lu.value) ~* '^.*\?$'
    OR CHR(lu.value) ~* ':'
    OR CHR(lu.value) ~* ';'
    OR CHR(lu.value) ~* '"'
)
SELECT * FROM aggregated_string;