SELECT title, 'Exists' AS status
FROM gh_v3_prd.project
WHERE title IN (
    'AI Assistants Part',
    'Ad Platform Shared Service Team',
    'Advance SW Group',
    'Cloud service Team',
    'Content Quality Part',
    'Enterprise Device Platform Part',
    'Enterprise OSU Part',
    'Family Hub',
    'Head Of R&D Center',
    'Intelligent Data Solutions Part',
    'International Assignment(VD)',
    'Kitchen AI Part',
    'People Partners - Business',
    'Product S/W R&D Lab',
    'Reliability Engineering Part',
    'Samsung R&D Institute India - Delhi [IA Home]',
    'Screen Experience Part',
    'Sensing AI Part',
    'Service Operations Group',
    'Talent & Org. Culture'
)
UNION ALL
SELECT title, 'Does Not Exist' AS status
FROM (
    SELECT 'AI Assistants Part' AS title
    UNION SELECT 'Ad Platform Shared Service Team'
    UNION SELECT 'Advance SW Group'
    UNION SELECT 'Cloud service Team'
    UNION SELECT 'Content Quality Part'
    UNION SELECT 'Enterprise Device Platform Part'
    UNION SELECT 'Enterprise OSU Part'
    UNION SELECT 'Family Hub'
    UNION SELECT 'Head Of R&D Center'
    UNION SELECT 'Intelligent Data Solutions Part'
    UNION SELECT 'International Assignment(VD)'
    UNION SELECT 'Kitchen AI Part'
    UNION SELECT 'People Partners - Business'
    UNION SELECT 'Product S/W R&D Lab'
    UNION SELECT 'Reliability Engineering Part'
    UNION SELECT 'Samsung R&D Institute India - Delhi [IA Home]'
    UNION SELECT 'Screen Experience Part'
    UNION SELECT 'Sensing AI Part'
    UNION SELECT 'Service Operations Group'
    UNION SELECT 'Talent & Org. Culture'
) AS all_titles
WHERE title NOT IN (
    SELECT title FROM gh_v3_prd.project
);



###output 
Cloud Service Team	Exists
Enterprise Device Platform Part	Exists
AI Assistants Part	Does Not Exist
Ad Platform Shared Service Team	Does Not Exist
Advance SW Group	Does Not Exist
Content Quality Part	Does Not Exist
Enterprise OSU Part	Does Not Exist
Family Hub	Does Not Exist
Head Of R&D Center	Does Not Exist
Intelligent Data Solutions Part	Does Not Exist
International Assignment(VD)	Does Not Exist
Kitchen AI Part	Does Not Exist
People Partners - Business	Does Not Exist
Product S/W R&D Lab	Does Not Exist
Reliability Engineering Part	Does Not Exist
Samsung R&D Institute India - Delhi [IA Home]	Does Not Exist
Screen Experience Part	Does Not Exist