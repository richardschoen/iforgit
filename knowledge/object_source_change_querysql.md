# List program objects and source change dates
In this document there are a couple of SQL queries you can use to get a good look at a list of objects 
in a library and their associated source files if any.

## This SQL query lists all the ILE bound module info for objects in selected library with module source info
It does show the associated source file info for each source member if you want to check source changes. 
```
 -- Select all bound module info including source
 -- file info for ILE program objects
  SELECT
        program_library,
        program_name,
        b.*
    FROM qsys2.bound_module_info  b
    WHERE program_library = 'YOURLIBNAME' 
    order by program_library,program_name;
```

## This query lists all program and command objects in a library. 
For ILE object you will get object change info, but source file info doesn't show up for ILE objects so this many not be as useful for you.
```
-- Get program statistics for selected library
-- Replace YOURLIBNAM with the object library you want to analyze
-- Note:Apparently ILE program objects don't store object info 
-- so won't show source file statistics.
-- TODO: How to get the source file for an ILE Object if needed ??
SELECT
    o.objlib                         AS object_library,
    o.objname                        AS object_name,
    o.objtype                        AS object_type,
    o.objattribute                   AS object_attribute,
    o.objtext                        AS object_text,

    o.objcreated                     AS object_created_timestamp,
    o.change_timestamp               AS object_last_changed_timestamp,

    o.source_library                 AS source_library,
    o.source_file                    AS source_file,
    o.source_member                  AS source_member,

    o.source_timestamp               AS source_timestamp_at_compile,
    s.last_source_update_timestamp   AS current_source_change_timestamp,
    CASE
        WHEN o.source_file IS NULL THEN 'NO SOURCE INFO IN OBJECT'
        WHEN s.system_table_member IS NULL THEN 'SOURCE MEMBER NOT FOUND'
        WHEN s.last_source_update_timestamp > o.source_timestamp THEN 'SOURCE CHANGED AFTER COMPILE'
        WHEN s.last_source_update_timestamp = o.source_timestamp THEN 'SOURCE MATCHES COMPILE'
        WHEN s.last_source_update_timestamp < o.source_timestamp THEN 'CURRENT SOURCE OLDER THAN COMPILED SOURCE'
        ELSE 'UNKNOWN'
    END AS impact_status,
    o.compiler,
    o.compiler_version
    -- Uncomment s.* and t.* below and put a comma 
    -- after o.compiler_version above 
    -- to see all available fields 
    --s.*,
    --o.*
 
FROM TABLE (
    qsys2.object_statistics(
        object_schema => 'YOURLIBNAME',
        objtypelist   => '*PGM *SRVPGM *MODULE *FILE *CMD'
    )
) AS o

LEFT JOIN qsys2.syspartitionstat AS s
    ON  s.system_table_schema = o.source_library
    AND s.system_table_name   = o.source_file
    AND s.system_table_member = o.source_member

WHERE o.objtype IN ('*PGM', '*SRVPGM', '*MODULE', '*FILE','*CMD')

ORDER BY
    --Uncomment impact_status to sort by impact status
    --impact_status,
    o.source_library,
    --o.source_file,
    --o.source_member,
    o.objname;    
```

## This SQL attempts to list all module info for RPGLE and CLLE objects. 
Youe mileage may vary with this query.

```
-- List module info for ILE objects

WITH pgms AS (
    SELECT
        objlib,
        objname,
        objtype,
        objattribute,
        objcreated,
        change_timestamp
    FROM TABLE (
        qsys2.object_statistics(
                   object_schema => 'YOURLIBNAME',
                   objtypelist   => '*PGM *SRVPGM *MODULE *FILE *CMD'        
        )
    )
    WHERE objattribute IN ('RPGLE', 'CLLE')
),

bound_modules AS (
    SELECT
        program_library,
        program_name,
        bound_module_library,
        bound_module,
        source_file_library,
        source_file,
        source_file_member 
    FROM qsys2.bound_module_info
    WHERE program_library = 'YOURLIBNAME'
),

module_objs AS (
    SELECT
        objlib,
        objname,
        objtype,
        objattribute,
        objcreated,
        change_timestamp,
        source_library,
        source_file,
        source_member,
        source_timestamp,
        compiler
    FROM TABLE (
        qsys2.object_statistics(
                   object_schema => 'QSHONI',
                   objtypelist   => '*PGM *SRVPGM *MODULE *FILE *CMD'
        )
    )
)

SELECT
    p.objlib                         AS program_library,
    p.objname                        AS program_name,
    p.objattribute                   AS program_attribute,
    p.objcreated                     AS program_created,
    p.change_timestamp               AS program_changed,

    bm.bound_module_library,
    bm.bound_module,
    bm.source_file_library,
    bm.source_file,
    bm.source_file_member,

    m.objattribute                   AS module_attribute,
    m.objcreated                     AS module_created_or_compiled,
    m.change_timestamp               AS module_changed,

    m.source_library,
    m.source_file,
    m.source_member,
    m.source_timestamp               AS source_when_module_compiled,

    s.last_source_update_timestamp   AS current_source_change_timestamp,

    CASE
        WHEN bm.bound_module IS NULL THEN 'NO BOUND MODULE ROW'
        WHEN m.objname IS NULL THEN 'MODULE OBJECT NOT FOUND'
        WHEN m.source_file IS NULL THEN 'NO SOURCE INFO ON MODULE'
        WHEN s.system_table_member IS NULL THEN 'SOURCE MEMBER NOT FOUND'
        WHEN s.last_source_update_timestamp > m.source_timestamp THEN 'SOURCE CHANGED AFTER MODULE COMPILE'
        ELSE 'SOURCE MATCHES OR OLDER'
    END AS impact_status

FROM pgms p

LEFT JOIN bound_modules bm
    ON  bm.program_library = p.objlib
    AND bm.program_name    = p.objname

LEFT JOIN module_objs m
    ON  m.objlib = bm.bound_module_library
    AND m.objname = bm.bound_module

LEFT JOIN qsys2.syspartitionstat s
    ON  s.system_table_schema = m.source_library
    AND s.system_table_name   = m.source_file
    AND s.system_table_member = m.source_member

ORDER BY
    p.objname,
    bm.bound_module;    
```    
    
    
    
 
    
