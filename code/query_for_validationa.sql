WITH file_data AS (
    SELECT 'AI Assistants Part' AS title, 'ai.assistants.part' AS code, 'part' AS project_level UNION ALL
    SELECT 'Ad platform Service Team', 'ad.platform.service.team', 'team' UNION ALL
    SELECT 'Adops Service Group', 'adops.service.group', 'group' UNION ALL
    SELECT 'Advance SW Group', 'advance.sw.group', 'group' UNION ALL
    SELECT 'Cloud service Team', 'cloud.service.team', 'team' UNION ALL
    SELECT 'Content Quality Part', 'content.quality.part', 'part' UNION ALL
    SELECT 'DA RT Product Part', 'da.rt.product.part', 'part' UNION ALL
    SELECT 'Data Platform Group', 'data.platform.group', 'group' UNION ALL
    SELECT 'Data Visualization', 'data.visualization', 'part' AS project_level UNION ALL
    SELECT 'Enterprise OSU Part', 'enterprise.osu.part', 'part' UNION ALL
    SELECT 'Family Hub', 'family.hub', 'part' AS project_level UNION ALL
    SELECT 'Graphics Part', 'graphics.part', 'part' UNION ALL
    SELECT 'Head Of R&D Center', 'head.of.rd.center', 'part' AS project_level UNION ALL
    SELECT 'IOT Middleware Part', 'iot.middleware.part', 'part' UNION ALL
    SELECT 'ISD Department', 'isd.department', 'part' AS project_level UNION ALL
    SELECT 'Infra & Security Group', 'infra.security.group', 'group' UNION ALL
    SELECT 'Intelligent Data Solutions Part', 'intelligent.data.solutions.part', 'part' UNION ALL
    SELECT 'International Assignment(VD)', 'international.assignment.vd', 'part' AS project_level UNION ALL
    SELECT 'Kitchen AI Part', 'kitchen.ai.part', 'part' UNION ALL
    SELECT 'Licensing Part', 'licensing.part', 'part' UNION ALL
    SELECT 'New Biz Solutions Part', 'new.biz.solutions.part', 'part' UNION ALL
    SELECT 'PVOD Part', 'pvod.part', 'part' UNION ALL
    SELECT 'People Partners', 'people.partners', 'part' AS project_level UNION ALL
    SELECT 'People Partners - Business', 'people.partners.business', 'part' AS project_level UNION ALL
    SELECT 'Product S/W R&D Lab', 'product.sw.rd.lab', 'part' AS project_level UNION ALL
    SELECT 'Reliability Engineering Part', 'reliability.engineering.part', 'part' UNION ALL
    SELECT 'Samsung R&D Institute India - Delhi [IA Home]', 'samsung.rd.institute.india.delhi.ia.home', 'part' AS project_level UNION ALL
    SELECT 'Screen Experience Part', 'screen.experience.part', 'part' UNION ALL
    SELECT 'Security Part', 'security.part', 'part' UNION ALL
    SELECT 'Sensing AI Part', 'sensing.ai.part', 'part' UNION ALL
    SELECT 'Service Operations Group', 'service.operations.group', 'group' UNION ALL
    SELECT 'Service operation Group', 'service.operation.group', 'group' UNION ALL
    SELECT 'Streaming Part', 'streaming.part', 'part' UNION ALL
    SELECT 'Talent & Org. Culture', 'talent.org.culture', 'part' AS project_level UNION ALL
    SELECT 'Tech Consulting & Presales  Part', 'tech.consulting.presales.part', 'part'
)

SELECT 
    CASE 
        WHEN p.id IS NULL THEN 'NEW ENTRY'
        WHEN f.title = p.title AND f.code = p.code THEN 'EXISTING AND IDENTICAL'
        ELSE 'EXISTING BUT DIFFERENT'
    END AS status,
    f.code AS file_code,
    f.title AS file_title,
    f.project_level AS file_project_level,
    COALESCE(p.code, 'N/A') AS db_code,
    COALESCE(p.title, 'N/A') AS db_title,
    COALESCE(p.project_level, 'N/A') AS db_project_level,
    CASE 
        WHEN p.id IS NULL THEN 'Needs to be added to database'
        WHEN f.title = p.title AND f.code = p.code THEN 'No action needed (identical)'
        WHEN f.code <> p.code THEN 'Code mismatch: ' || f.code || ' vs ' || p.code
        WHEN f.title <> p.title THEN 'Title mismatch: ' || f.title || ' vs ' || p.title
        WHEN f.project_level <> p.project_level THEN 'Project level mismatch: ' || f.project_level || ' vs ' || COALESCE(p.project_level, 'NULL')
        ELSE 'Needs investigation'
    END AS action_required
FROM file_data f
LEFT JOIN gh_v3_prd.project p ON f.title = p.title OR f.code = p.code
ORDER BY 
    CASE 
        WHEN p.id IS NULL THEN 1
        WHEN f.title = p.title AND f.code = p.code THEN 3
        ELSE 2
    END,
    f.code;