-- Task 1
SELECT SUM(value) TOTAL_SGA_IN_BYTES FROM V$SGA;
-- Task 2
SELECT NAME POOL_NAME, VALUE SIZE_IN_BUTES FROM V$SGA;
-- Task 3
SELECT component, granule_size FROM gv$sga_dynamic_components;
-- Task 4
SELECT current_size FROM gv$sga_dynamic_free_memory;
-- Task 5
SELECT name, value FROM v$parameter WHERE name IN ('sga_target', 'sga_max_size');
-- Task 6
SELECT COMPONENT, MIN_SIZE, MAX_SIZE, CURRENT_SIZE FROM gv$sga_dynamic_components
WHERE COMPONENT IN ('KEEP buffer cache', 'RECYCLE buffer cache', 'DEFAULT buffer cache');
-- Task 7
CREATE TABLE KEEP_POOL_TABLE (num NUMBER) STORAGE (buffer_pool keep);
INSERT ALL
    INTO KEEP_POOL_TABLE VALUES (1)
    INTO KEEP_POOL_TABLE VALUES (2)
    INTO KEEP_POOL_TABLE VALUES (3)
SELECT * FROM DUAL;

SELECT * FROM KEEP_POOL_TABLE;
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM user_segments WHERE SEGMENT_NAME LIKE 'KEEP%';
-- Task 8
CREATE TABLE DEFAULT_CACHE_TABLE (num NUMBER) STORAGE (buffer_pool default);
INSERT ALL
    INTO DEFAULT_CACHE_TABLE VALUES (4)
    INTO DEFAULT_CACHE_TABLE VALUES (5)
SELECT * FROM DUAL;

SELECT * FROM DEFAULT_CACHE_TABLE;
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM user_segments WHERE segment_name LIKE 'DEFAULT_CACHE%';
-- Task 9
SELECT NAME, VALUE 
FROM V$PARAMETER 
WHERE NAME = 'log_buffer';
-- Task 10
SELECT pool, name, bytes FROM v$sgastat 
WHERE pool = 'large pool' AND name = 'free memory';
-- Task 11
SELECT SID, STATUS, SERVER, LOGON_TIME, PROGRAM, OSUSER, MACHINE, USERNAME, STATE
FROM v$session
WHERE STATUS = 'ACTIVE';
-- Task 12
SELECT sid, process, name, description, program, s.STATUS
FROM v$session s 
JOIN v$bgprocess USING (paddr)
-- Task 13
SELECT * FROM v$process;
-- Task 14
SELECT * FROM v$process WHERE pname LIKE 'DBW%';
-- Task 15
-- servis
SELECT NAME, NETWORK_NAME, PDB FROM v$services;
-- Task 16
SELECT * FROM V$DISPATCHER; 
-- Task 17
-- services.msc=>OracleOraDB12Home1TNSListener
-- Task 18
-- /opt/oracle/oradata/dbconfig/FREE/listener.ora
-- Task 19
-- start, stop, status, services, version, reload, save_config, trace, quit, exit, set, show
-- Task 20
-- lsnrctl=>services

-- answer 17
SELECT sid, SERIAL#, USERNAME, PROGRAM, STATUS
from V$SESSION