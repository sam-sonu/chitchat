Table: content_training
Columns:
id int AI PK 
pid int UN 
parent_id int UN 
title varchar(300) 
code varchar(100) 
ref_link varchar(200) 
trainer_id int UN 
project_id varchar(200) 
event_dt datetime(6) 
event_type_cd varchar(200) 
location varchar(200) 
skill_id int UN 
current_level_cd varchar(30) 
target_level_cd varchar(30) 
user_id_arr varchar(5000) 
status_cd varchar(200) 
sno int UN 
del_yn varchar(1) 
modifier_id int UN 
modify_dt datetime(6) 
creator_id int UN 
create_dt datetime(6) 
obj_cd varchar(50) 
end_time varchar(50) 
start_time varchar(50) 
description longtext 
external_survey_yn varchar(1) 
external_survey_url varchar(200) 
trainer_id_arr varchar(5000) 
show_yn varchar(1) 
module_id int UN 
program_id int UN 
co_author_id_arr varchar(1000) 
feedback_show_yn varchar(1) 
nomination_yn varchar(1) 
mandatory_yn varchar(1) 
training_size int 
training_type_cd varchar(50) 
approval_yn varchar(1) 
email_yn varchar(1) 
reminder_yn varchar(1) 
verified_yn varchar(1)




Table: content_training_member
Columns:
id bigint UN AI PK 
training_id int UN 
member_id int UN 
role_cd varchar(50) 
feedback varchar(1000) 
rating int 
user_attended_yn varchar(1) 
status_cd varchar(200) 
sno int UN 
del_yn varchar(1) 
modifier_id int UN 
modify_dt datetime(6) 
creator_id int UN 
create_dt datetime(6) 
obj_cd varchar(50) 
rating_cd varchar(50) 
nominated_yn varchar(1)


WITH training_stats AS (
    -- Get overall training statistics (now based on member status)
    SELECT 
        NULL AS member_id,
        COUNT(DISTINCT t.id) AS total_training_cnt,
        SUM(
            CASE 
                WHEN m.status_cd IN ('status.complete', 'status.feedback.complete') 
                THEN TIMESTAMPDIFF(
                    MINUTE,
                    STR_TO_DATE(CONCAT(DATE(t.event_dt), ' ', t.start_time), '%Y-%m-%d %H:%i'),
                    STR_TO_DATE(CONCAT(DATE(t.event_dt), ' ', t.end_time), '%Y-%m-%d %H:%i')
                ) / 60.0
                ELSE 0 
            END
        ) AS total_training_hr,
        SUM(CASE WHEN m.status_cd IN ('status.complete', 'status.feedback.complete') THEN 1 ELSE 0 END) AS total_training_completed_cnt,
        SUM(CASE WHEN m.status_cd = 'status.draft' THEN 1 ELSE 0 END) AS total_training_inprogress_cnt
    FROM 
        content_training_member m
    JOIN 
        content_training t ON m.training_id = t.id
    WHERE 
        (m.del_yn = 'N' OR m.del_yn IS NULL)
        AND (t.del_yn = 'N' OR t.del_yn IS NULL)
    
    UNION ALL
    
    -- Get member-specific training statistics
    SELECT 
        m.member_id,
        COUNT(DISTINCT t.id) AS total_training_cnt,
        SUM(
            CASE 
                WHEN m.status_cd IN ('status.complete', 'status.feedback.complete') 
                THEN TIMESTAMPDIFF(
                    MINUTE,
                    STR_TO_DATE(CONCAT(DATE(t.event_dt), ' ', t.start_time), '%Y-%m-%d %H:%i'),
                    STR_TO_DATE(CONCAT(DATE(t.event_dt), ' ', t.end_time), '%Y-%m-%d %H:%i')
                ) / 60.0
                ELSE 0 
            END
        ) AS total_training_hr,
        SUM(CASE WHEN m.status_cd IN ('status.complete', 'status.feedback.complete') THEN 1 ELSE 0 END) AS total_training_completed_cnt,
        SUM(CASE WHEN m.status_cd = 'status.draft' THEN 1 ELSE 0 END) AS total_training_inprogress_cnt
    FROM 
        content_training_member m
    JOIN 
        content_training t ON m.training_id = t.id
    WHERE 
        (m.del_yn = 'N' OR m.del_yn IS NULL)
        AND (t.del_yn = 'N' OR t.del_yn IS NULL)
        AND m.member_id = 2790  -- Added filter here to only include relevant member
    GROUP BY 
        m.member_id
)

-- Final result with dynamic member_id filter
SELECT 
    member_id,
    total_training_cnt,
    ROUND(total_training_hr, 1) AS total_training_hr_actual,
    CEILING(total_training_hr) AS total_training_hr_rounded,
    total_training_completed_cnt,
    total_training_inprogress_cnt
FROM training_stats
WHERE 
    member_id = 2790
ORDER BY 
    CASE WHEN member_id IS NULL THEN 0 ELSE 1 END,
    member_id;