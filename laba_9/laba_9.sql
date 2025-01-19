BEGIN

SET SERVEROUTPUT ON;
ALTER PLUGGABLE DATABASE SNE_PDB OPEN;

-- Task 1
DECLARE
    CURSOR USER_CURSOR IS
    SELECT USERNAME
    FROM DBA_USERS;
    NAMA SYS.DBA_USERS.USERNAME%TYPE;
    MYLENGTH NUMBER := 0;
BEGIN
    OPEN USER_CURSOR;
    LOOP
        FETCH USER_CURSOR INTO NAMA;
        EXIT WHEN USER_CURSOR%NOTFOUND;
        MYLENGTH := MYLENGTH + 1;
        DBMS_OUTPUT.PUT_LINE(MYLENGTH || ') ' || NAMA);
    END LOOP;

    CLOSE USER_CURSOR;
END;
 
-- Task 2-4
DECLARE
    MY_USERNAME SYS.DBA_USERS.USERNAME%TYPE;
BEGIN
    SELECT USERNAME INTO MY_USERNAME
    FROM DBA_USERS

    --WHERE USERNAME LIKE '%S%';
    --WHERE USERNAME LIKE '1%';
    
    WHERE USERNAME LIKE '%1%';

    DBMS_OUTPUT.PUT_LINE(MY_USERNAME);

    DBMS_OUTPUT.PUT_LINE('SQL%ROWCOUNT: ' || SQL%ROWCOUNT); 
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
         DBMS_OUTPUT.PUT_LINE('More then 1');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('error: no data');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('error: ' || SQLERRM || '; Code: ' || SQLCODE);
END;

-- Task 5
CREATE TABLE test_table (
    id NUMBER PRIMARY KEY,
    value VARCHAR2(50)
);

INSERT INTO test_table (id, value) VALUES (1, 'Value 1');
INSERT INTO test_table (id, value) VALUES (2, 'Value 2');
COMMIT;

DECLARE
    upd BOOLEAN := FALSE;
BEGIN
    UPDATE test_table
    SET value = 'Value 1.1'
    WHERE id = 1;

    --IF SQL%ROWCOUNT = 0 THEN
    IF SQL%ROWCOUNT > 0 THEN
        upd := TRUE;
    END IF;

    UPDATE test_table
    SET value = 'Value 2.2'
    WHERE id = 2;

    IF upd THEN
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Commit.');
    ELSE
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('Rollback.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

SELECT * FROM test_table;

-- Task 6
CREATE TABLE parent_table (
    id NUMBER PRIMARY KEY
);

CREATE TABLE child_table (
    id NUMBER PRIMARY KEY,
    parent_id NUMBER,
    CONSTRAINT fk_parent FOREIGN KEY (parent_id) REFERENCES parent_table(id)
);

INSERT INTO parent_table (id) VALUES (1);
INSERT INTO parent_table (id) VALUES (2);

INSERT INTO child_table (id, parent_id) VALUES (11, 1);
COMMIT;

BEGIN
    UPDATE child_table
    --SET parent_id = 3
    SET parent_id = 2
    WHERE id = 11;

    COMMIT; 
    DBMS_OUTPUT.PUT_LINE('All correct.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('error: ' || SQLERRM);
END;

SELECT * FROM parent_table;
SELECT * FROM child_table;

-- Task 7, 8
BEGIN
    INSERT INTO child_table 
    VALUES(111, 4);
    --VALUES(111, 1);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('All correct.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('error: ' || SQLERRM);
END;

SELECT * FROM parent_table;
SELECT * FROM child_table;

-- Task 9, 10
BEGIN
    DELETE FROM parent_table 
    WHERE id = 1;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Commit.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('error: ' || SQLERRM);
END;

SELECT * FROM parent_table;
SELECT * FROM child_table;

-- Task 11
DECLARE
    CURSOR teacher_cursor IS
        SELECT * FROM teacher;

    c_teach teacher.teacher%TYPE;
    c_name teacher.teacher_name%TYPE;
    c_pulpit teacher.pulpit%TYPE;
BEGIN
    OPEN teacher_cursor;

    LOOP
        FETCH teacher_cursor INTO c_teach, c_name, c_pulpit;

        EXIT WHEN teacher_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('ID: ' || c_teach || '; Name: ' || c_name || '; Subject: ' || c_pulpit);
    END LOOP;

    CLOSE teacher_cursor;
END;

-- Task 12
DECLARE
    CURSOR subject_cursor IS 
        SELECT SUBJECT, SUBJECT_NAME FROM subject;

    c_subj subject.subject%type;
    c_name subject.SUBJECT_NAME%type;
BEGIN
    OPEN subject_cursor;

    FETCH subject_cursor into c_subj, c_name;

    WHILE NOT subject_cursor%NOTFOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Subj: ' || c_subj || '; Name: ' || c_name);
        FETCH subject_cursor into c_subj, c_name;
    END LOOP;

    CLOSE subject_cursor;
END;

-- Task 13
DECLARE
    CURSOR teacher_cursor IS
        SELECT p.pulpit_name AS pulpit_name, t.TEACHER_NAME AS teacher_name
        FROM pulpit p
        INNER JOIN teacher t ON p.pulpit = t.pulpit;

BEGIN
    FOR rec IN teacher_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Pulpit: ' || rec.pulpit_name || '; Teacher: ' || rec.teacher_name);
    END LOOP;
END;

-- Task 14
DECLARE
    CURSOR AUDITORIUM_CURSOR(p_min_size NUMBER, p_max_size NUMBER) IS
        SELECT AUDITORIUM, AUDITORIUM_CAPACITY
        FROM AUDITORIUM
        WHERE AUDITORIUM_CAPACITY BETWEEN p_min_size AND p_max_size;

    c_id AUDITORIUM.AUDITORIUM%TYPE;
    c_size AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Less then 20:');
    FOR rec IN AUDITORIUM_CURSOR(0, 20) LOOP
        DBMS_OUTPUT.PUT_LINE('Id: ' || rec.AUDITORIUM || '; Size: ' || rec.AUDITORIUM_CAPACITY);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Between 21 and 30:');
    OPEN AUDITORIUM_CURSOR(21, 30);
    LOOP
        FETCH AUDITORIUM_CURSOR INTO c_id, c_size;
        EXIT WHEN AUDITORIUM_CURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Id: ' || c_id || '; Size: ' || c_size);
    END LOOP;
    CLOSE AUDITORIUM_CURSOR;

    DBMS_OUTPUT.PUT_LINE('Between 31 and 60:');
    OPEN AUDITORIUM_CURSOR(31, 60);
    FETCH AUDITORIUM_CURSOR INTO c_id, c_size;
    WHILE AUDITORIUM_CURSOR%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Id: ' || c_id || '; Size: ' || c_size);
        FETCH AUDITORIUM_CURSOR INTO c_id, c_size;
    END LOOP;
    CLOSE AUDITORIUM_CURSOR;

    DBMS_OUTPUT.PUT_LINE('Between 61 and 80:');
    FOR rec IN AUDITORIUM_CURSOR(61, 80) LOOP
        DBMS_OUTPUT.PUT_LINE('Id: ' || rec.AUDITORIUM || '; Size: ' || rec.AUDITORIUM_CAPACITY);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('More then 81:');
    FOR rec IN AUDITORIUM_CURSOR(81, 100) LOOP
        DBMS_OUTPUT.PUT_LINE('Id: ' || rec.AUDITORIUM || '; Size: ' || rec.AUDITORIUM_CAPACITY);
    END LOOP;
END;

-- Task 15
DECLARE
    TYPE ref_cursor_type IS REF CURSOR;
    rc ref_cursor_type;

    c_id AUDITORIUM.AUDITORIUM%TYPE;
    c_size AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;

    PROCEDURE open_cursor(p_min_size NUMBER, p_max_size NUMBER, c_ref_cursor OUT ref_cursor_type) IS
    BEGIN
        OPEN c_ref_cursor FOR
            SELECT AUDITORIUM, AUDITORIUM_CAPACITY
            FROM AUDITORIUM
            WHERE AUDITORIUM_CAPACITY BETWEEN p_min_size AND p_max_size;
    END;
BEGIN
    open_cursor(20, 80, rc);

    DBMS_OUTPUT.PUT_LINE('Between 20 and 80:');
    
    LOOP
        FETCH rc INTO c_id, c_size;
        EXIT WHEN rc%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Id: ' || c_id || '; Size: ' || c_size);
    END LOOP;

    CLOSE rc;
END;

-- Task 16
DECLARE
    CURSOR auditorium_cursor IS
        SELECT AUDITORIUM,AUDITORIUM_CAPACITY
        FROM AUDITORIUM
        WHERE AUDITORIUM IN (
            SELECT DISTINCT AUDITORIUM
            FROM AUDITORIUM
            WHERE AUDITORIUM_CAPACITY > 50
        );

    c_id AUDITORIUM.AUDITORIUM%TYPE;
    c_size AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
    OPEN auditorium_cursor;
    LOOP
        FETCH auditorium_cursor INTO c_id, c_size;
        EXIT WHEN auditorium_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Id: ' || c_id || '; Size: ' || c_size);
    END LOOP;

    CLOSE auditorium_cursor;
END;

-- Task 17
DECLARE
    CURSOR auditorium_cursor(p_min_size NUMBER, p_max_size NUMBER) IS
        SELECT AUDITORIUM, AUDITORIUM_CAPACITY
        FROM AUDITORIUM
        WHERE AUDITORIUM_CAPACITY BETWEEN p_min_size AND p_max_size
        FOR UPDATE;
BEGIN
    FOR rec IN auditorium_cursor(40, 80) LOOP
        DBMS_OUTPUT.PUT_LINE('Was: Id: ' || rec.AUDITORIUM || '; Size: ' || rec.AUDITORIUM_CAPACITY);
    END LOOP;
    FOR rec IN auditorium_cursor(40, 80) LOOP
        UPDATE AUDITORIUM
        SET AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY * 0.9
        WHERE CURRENT OF auditorium_cursor; 
    END LOOP;
    FOR rec IN auditorium_cursor(40, 80) LOOP
        DBMS_OUTPUT.PUT_LINE('Fin: Id: ' || rec.AUDITORIUM || '; Size: ' || rec.AUDITORIUM_CAPACITY);
    END LOOP;

    COMMIT;
END;
--UPDATE, REBUILD

-- Task 18
DECLARE
    CURSOR auditorium_cursor(p_min_size NUMBER, p_max_size NUMBER) IS
        SELECT AUDITORIUM
        FROM auditorium
        WHERE AUDITORIUM_CAPACITY BETWEEN p_min_size AND p_max_size
        FOR UPDATE;

    c_id AUDITORIUM.AUDITORIUM%TYPE;
BEGIN
    OPEN auditorium_cursor(0, 20);

    FETCH auditorium_cursor INTO c_id;
    WHILE NOT auditorium_cursor%NOTFOUND LOOP
        DELETE FROM AUDITORIUM
        WHERE CURRENT OF auditorium_cursor;

        DBMS_OUTPUT.PUT_LINE('id: ' || c_id || ' delete');

        FETCH auditorium_cursor INTO c_id;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('All delete');
END;

select * from AUDITORIUM;
--DELETE, REBUILD

-- Task 19
DECLARE
    c_rowid ROWID; 
BEGIN
    SELECT ROWID 
    INTO c_rowid
    FROM AUDITORIUM
    WHERE AUDITORIUM_CAPACITY > 50 AND ROWNUM = 1;
    
    UPDATE AUDITORIUM
    SET AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY + 10
    WHERE ROWID = c_rowid;

    DBMS_OUTPUT.PUT_LINE('Row ' || c_rowid || ' updated.');

    DELETE FROM AUDITORIUM
    WHERE ROWID = c_rowid;

    DBMS_OUTPUT.PUT_LINE('Row ' || c_rowid || ' deleted.');

    COMMIT;
END;

-- Task 20
DECLARE
    CURSOR auditorium_cursor IS
        SELECT AUDITORIUM, AUDITORIUM_CAPACITY
        FROM AUDITORIUM;

    c_id AUDITORIUM.AUDITORIUM%TYPE;
    c_size AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
    count_of_auditorium NUMBER; 
BEGIN
    OPEN auditorium_cursor;

    SELECT COUNT(*) INTO count_of_auditorium FROM AUDITORIUM;
    
    FOR i IN 1..count_of_auditorium LOOP
        FETCH auditorium_cursor INTO c_id, c_size;
        DBMS_OUTPUT.PUT_LINE('Id: ' || c_id || '; Size: ' || c_size);

        IF MOD(i, 3) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('=========================================');
        END IF;
    END LOOP;

    CLOSE auditorium_cursor;
END;


END;