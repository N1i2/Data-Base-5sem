grant create trigger, drop any trigger to U1_SNE_PDB;
grant create procedure to U1_SNE_PDB;

SET SERVEROUTPUT ON;

-- Task 1

DELETE from SOURCE_TABLE;
DELETE from TARGET_TABLE; 
DELETE from JOB_LOG; 

SELECT * FROM SOURCE_TABLE;
SELECT * FROM TARGET_TABLE;

CREATE TABLE SOURCE_TABLE (
    ID NUMBER PRIMARY KEY,
    Data VARCHAR2(100),
    Created_At DATE DEFAULT SYSDATE
);

CREATE TABLE TARGET_TABLE (
    ID NUMBER PRIMARY KEY,
    Data VARCHAR2(100),
    Moved_At DATE DEFAULT SYSDATE
);

CREATE TABLE JOB_LOG (
    Execution_Time DATE DEFAULT SYSDATE,
    Status VARCHAR2(20),
    Error_Message VARCHAR2(500)
);

BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO SOURCE_TABLE (id, Data)
        VALUES (i, 'Data_' || i);
    END LOOP;
    COMMIT;
END;


-- Task2 
CREATE OR REPLACE PROCEDURE COPY_AND_CLEAN_JOB AS
    v_error_message VARCHAR2(500); 
BEGIN
    INSERT INTO TARGET_TABLE (ID, Data)
    SELECT ID, Data 
    FROM SOURCE_TABLE;

    DELETE FROM SOURCE_TABLE;

    INSERT INTO JOB_LOG (Status, Error_Message)
    VALUES ('SUCCESS', NULL);

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        v_error_message := SQLERRM;

        INSERT INTO JOB_LOG (Status, Error_Message)
        VALUES ('FAILED', v_error_message);

        COMMIT;
END;
/

-- DBMS_JOB.SUBMIT 
GRANT CREATE JOB TO U1_SNE_PDB;
GRANT EXECUTE ON DBMS_JOB TO U1_SNE_PDB;
GRANT EXECUTE ON DBMS_SCHEDULER TO U1_SNE_PDB;

DECLARE
    job_id NUMBER;
BEGIN
    DBMS_JOB.SUBMIT(
        job        => job_id,
        what       => 'BEGIN COPY_AND_CLEAN_JOB; END;',
        next_date  => TRUNC(SYSDATE + 7) + 8/24,
        interval   => 'TRUNC(SYSDATE + 7) + 8/24'
    );
    DBMS_OUTPUT.PUT_LINE('Job ID: ' || job_id);
    COMMIT;
END;
/

-- Task4 

SELECT * FROM USER_JOBS;
SELECT * FROM JOB_LOG;
SELECT * FROM SOURCE_TABLE;
SELECT * FROM TARGET_TABLE;

-- Task5 
BEGIN
    DBMS_JOB.RUN(4);
END;
/

BEGIN
    DBMS_JOB.BROKEN(4, TRUE);
END;
/

BEGIN
    DBMS_JOB.BROKEN(4, FALSE);
END;
/

BEGIN
    DBMS_JOB.REMOVE(job => 4);
END;
/

-- Task6 
-- DBMS_SCHEDULER
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        program_name   => 'COPY_AND_CLEAN_PROGRAM',
        program_type   => 'PLSQL_BLOCK',
        program_action => 'BEGIN COPY_AND_CLEAN_JOB; END;',
        number_of_arguments => 0,
        enabled        => TRUE
    );
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
        schedule_name => 'WEEKLY_SCHEDULE',
        start_date    => SYSTIMESTAMP,
        repeat_interval => 'FREQ=WEEKLY; BYDAY=MON; BYHOUR=8; BYMINUTE=0; BYSECOND=0',
        comments      => 'Выполнение по понедельникам в 8:00'
    );
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name        => 'COPY_AND_CLEAN_JOB_TASK',
        program_name    => 'COPY_AND_CLEAN_PROGRAM',
        schedule_name   => 'WEEKLY_SCHEDULE',
        enabled         => TRUE
    );
END;
/

SELECT JOB_NAME, STATE FROM USER_SCHEDULER_JOBS;
SELECT * FROM JOB_LOG;
SELECT * FROM SOURCE_TABLE;
SELECT * FROM TARGET_TABLE;

BEGIN
    DBMS_SCHEDULER.RUN_JOB('COPY_AND_CLEAN_JOB_TASK');
END;
/

BEGIN
    DBMS_SCHEDULER.DISABLE('COPY_AND_CLEAN_JOB_TASK');
END;
/

BEGIN
    DBMS_SCHEDULER.ENABLE('COPY_AND_CLEAN_JOB_TASK');
END;
/

BEGIN
    DBMS_SCHEDULER.DROP_JOB(job_name => 'COPY_AND_CLEAN_JOB_TASK', force => TRUE);
END;
/

BEGIN
    DBMS_SCHEDULER.DROP_SCHEDULE(schedule_name => 'WEEKLY_SCHEDULE', force => TRUE);
END;
/

BEGIN
    DBMS_SCHEDULER.DROP_PROGRAM(program_name => 'COPY_AND_CLEAN_PROGRAM', force => TRUE);
END;
/


SELECT job_name, enabled
FROM user_scheduler_jobs
WHERE job_name = 'COPY_AND_CLEAN_JOB';