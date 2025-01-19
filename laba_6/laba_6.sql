-- Task №1  
--/opt/oracle/oradata/dbconfig/FREE/sqlnet.ora
--/opt/oracle/oradata/dbconfig/FREE/tnsnames.ora

-- Task №2  
SELECT NAME, DESCRIPTION, VALUE FROM v$parameter;

-- Task №3  
-- conn system/oracle_user@//localhost:1521/SNE_PDB;
-- or conn sqlplus / as sysdba

SELECT * FROM dba_tablespaces;
SELECT TABLESPACE_NAME, FILE_NAME FROM dba_data_files;
SELECT * FROM dba_roles;
SELECT * FROM dba_users;

ALTER PLUGGABLE DATABASE SNE_PDB OPEN;

-- Task №4  
--in windows (win+r -> cmd -> regedit)

-- Task №5 
--conn U1_SNE_PDB/pdb1234@SNE_PDB;

-- Task №6 
-- sqlplus U1_SNE_PDB/pdb1234@localhost:1521/SNE_PDB

-- Task №7  
select * from SNE_TABLE;

-- Task №8  
--help timing
--timi start;
--select * from dba_roles;
--timi stop;

-- Task №9  
--desc
--desc SNE_TABLE;

-- Task №10  
select * from user_segments;

-- Task №11  
DROP VIEW view_segments;
create view view_segments as
    select count(SEGMENT_NAME) segments_count, sum(EXTENTS) extents_count,
           sum(BLOCKS) bloks_memory_count, sum(BYTES) blocks_memory_size
    from user_segments;
select * from view_segments;