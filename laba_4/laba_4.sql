--Task 1
select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;

--Task 2
--drop tablespace SNE_QDATA including contents and datafiles;
create tablespace SNE_QDATA
  datafile 'SNE_QDATA.dbf'
  size 10M
  offline;

alter tablespace SNE_QDATA online;

alter user SNECORE quota 2M on SNE_QDATA;

--SNECORE
-- drop table SNE_T1
create table SNE_T1 (
    x int primary key,
    s varchar2(50)
) tablespace SNE_QDATA;

insert all
    into SNE_T1 values (1, 'hi')
    into SNE_T1 values (2, 'hello')
    into SNE_T1 values (3, 'hel')
select * from dual;

Select * from SNE_T1;

--Task 3
select SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BYTES, blocks, extents
from USER_SEGMENTS
where TABLESPACE_NAME='SNE_QDATA';

select * from USER_SEGMENTS;

--Task 4
drop table SNE_T1;
select * from USER_SEGMENTS where TABLESPACE_NAME='SNE_QDATA';

select * from USER_RECYCLEBIN;
--purge table SNE_T1;

--Task 5
flashback table SNE_T1 to before drop;

--Task 6
TRUNCATE TABLE SNE_T1;
begin
  for x in 1..10000
  loop
    insert into SNE_T1 values(x, 'hello');
  end loop;
end;

select count(*) from SNE_T1;

--Task 7
select segment_name, bytes, BLOCKS from USER_SEGMENTS where TABLESPACE_NAME = 'SNE_QDATA';
select * from USER_SEGMENTS;
select * from USER_EXTENTS;

--Task 8
--SYS
Commit;
drop tablespace SNE_QDATA including contents and datafiles;
select * from dba_tablespaces

--Task 9
select * from V$LOG order by GROUP#;

--Task 10
select * from V$LOGFILE order by GROUP#;

--Task 11
alter system switch logfile;
select * from V$LOG order by GROUP#;

--Task 12
alter database add logfile
    group 4
    '/opt/oracle/oradata/FREE/REDO04.LOG'
    size 50m
    blocksize 512;
alter database add logfile
    member
    '/opt/oracle/oradata/FREE/REDO04_1.LOG'
    to group 4;
alter database add logfile
    member
    '/opt/oracle/oradata/FREE/REDO04_2.LOG'
    to group 4;

select * from V$LOG order by GROUP#;
select GROUP#, MEMBER from V$LOGFILE order by GROUP#;

--Task 13
--alter system checkpoint;
--alter database drop logfile member '/opt/oracle/oradata/FREE/REDO04_2.LOG';
--alter database drop logfile member '/opt/oracle/oradata/FREE/REDO04_1.LOG';
--alter database drop logfile group 4;

select * from V$LOG order by GROUP#;
select * from V$LOGFILE order by GROUP#;

--Task 14
--LOG_MODE = NOARCHIVELOG; ARCHIVER = STOPPED
select DBID, NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

--Task 15
select * from V$ARCHIVED_LOG;

--Task 16
-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;

select DBID, NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

--Task 17
alter system set LOG_ARCHIVE_DEST_1 ='LOCATION=/opt/oracle/oradata/FREE/Archive';
select * from V$ARCHIVED_LOG;
alter system switch logfile;
select * from V$LOG order by GROUP#;

--Task 18
-- shutdown immediate;
-- startup mount;
-- alter database noarchivelog;
-- alter database open;

select DBID, name, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from V$INSTANCE;

--Task 19
select * from V$CONTROLFILE;

--Task 20
--show parameter control;
select * from V$CONTROLFILE_RECORD_SECTION;


--Task 21
--show parameter spfile;
select NAME, DESCRIPTION from V$PARAMETER;


--Task 22
create pfile = 'SNE_PFILE.ora' from spfile;

--Task 23
--show parameter remote_login_passwordfile;
select * from V$PWFILE_USERS;

--Task 24
select * from V$DIAG_INFO;

--Task 25
--/opt/orcl/orcl/alert/log.xml

--3 вопрос
--где искали scn