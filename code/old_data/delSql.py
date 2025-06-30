-- First identify the primary key column name (common variations: id, module_id, etc.)
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'gh_v3_prd' 
  AND TABLE_NAME = 'content_course_module' 
  AND COLUMN_KEY = 'PRI';

-- Then use in deletion (example using 'id' as PK)
DELETE FROM gh_v3_prd.content_course_module
WHERE id IN (
    SELECT id FROM (
        SELECT id 
        FROM gh_v3_prd.content_course_module 
        WHERE status_cd = 'ACTIVE'
    ) AS temp
);



#to delete the revoedd if required