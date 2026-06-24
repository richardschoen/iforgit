# List Source Member Change Info for Selected Library
This SQL query van be used to list all source member change information for a selected library.
You should be able to run this query in IBM ACS Run SQL or other SQL utility. 

Just copy/paste this into ACS Run SQL and replace ```YOURLIBNAME``` with the library you want to analyze source membeers for.


```
-- List source file members and dates for selected library
SELECT
    P.TABLE_SCHEMA        AS LIBRARY,
    P.TABLE_NAME          AS SOURCE_FILE,
    P.TABLE_PARTITION     AS MEMBER,
    P.SOURCE_TYPE         AS SOURCETYPE,     
    P.PARTITION_TEXT      AS TEXTDESC, 
    P.NUMBER_ROWS         AS SOURCELINES,
    P.CREATE_TIMESTAMP AS CREATETIME,
    P.LAST_CHANGE_TIMESTAMP AS LASTCHANGETIME,
    P.LAST_SOURCE_UPDATE_TIMESTAMP AS LASTSRCUPDATETIME
    -- All extra fields if you want them
    -- Just uncomment T.* and P.* and add a comma after
    -- LASTSRCUPDATETIME above.
    --T.*,
    --P.*   
FROM QSYS2.SYSPARTITIONSTAT P
JOIN QSYS2.SYSTABLES T
  ON  T.TABLE_SCHEMA = P.TABLE_SCHEMA
  AND T.TABLE_NAME   = P.TABLE_NAME
WHERE P.TABLE_SCHEMA = 'YOURLIBNAME'
  AND T.TABLE_TYPE = 'P'
  AND T.FILE_TYPE = 'S'
ORDER BY
    P.LAST_CHANGE_TIMESTAMP DESC;
```
