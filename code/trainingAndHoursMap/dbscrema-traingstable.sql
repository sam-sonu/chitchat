Table: content_training
Columns:
id int AI PK 
pid int UN   -> 0
parent_id int UN    -> 0
title varchar(300)  -> form txt file-> Training Title
code varchar(100)   -> ''
ref_link varchar(200)  -> from txt file -> Provider
trainer_id int UN    -> ''
project_id varchar(200)  -> 0
event_dt datetime(6)    -> from txt file -> Completion Date
event_type_cd varchar(200)   -> "training.event.type.online"
location varchar(200)   -> "Provider"
skill_id int UN    -> SELECT id FROM gh_v3_prd.skill where title ="Software R&D (JFG)" (from skill table based on title of skill in txt file)
current_level_cd varchar(30)   -> "skill.level.intermediate"
target_level_cd varchar(30)    -> "skill.level.advance"
user_id_arr varchar(5000)      -> form txt file add all -> find all user and add User Email Address for this training like s.patidar@samsung.com,ayush.yogi@samsung.com,h1.chauhan@samsung.com,shreya.shama@samsung.com,...
status_cd varchar(200)   -> form txt file -> Training Attendee Status
sno int UN    -> 0
del_yn varchar(1)   -> N
modifier_id int UN   -> 61
modify_dt datetime(6) -> Now
creator_id int UN  -> 1975 
create_dt datetime(6)    -> Now
obj_cd varchar(50)    -> 'content.training'
start_time varchar(50)  -> end_time varchar(50)   -> Training Hours (make dfirrent with training hours and fill a any time afer 2 pm to 6 pm) example - Training Hours = 4 then start_time = 2pm and end_time = 6pm
description longtext   -> from txt file -> Training title
external_survey_yn varchar(1)   -> N
external_survey_url varchar(200)  -> ''
trainer_id_arr varchar(5000)    -> " "
show_yn varchar(1)   -> Y
module_id int UN   -> 0
program_id int UN  -> 0
co_author_id_arr varchar(1000)   -> ''
feedback_show_yn varchar(1)    -> Y
nomination_yn varchar(1)       -> N
mandatory_yn varchar(1)        -> N
training_size int              -> null
training_type_cd varchar(50)   -> 'by.ld'
approval_yn varchar(1)   -> N
email_yn varchar(1)      ->  N
reminder_yn varchar(1)   ->  Y
verified_yn varchar(1)   -> N