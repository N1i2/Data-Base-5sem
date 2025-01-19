SET SERVEROUTPUT ON;

GRANT CREATE TRIGGER TO U1_SNE_PDB; 

--  Task 1
drop TRIGGER trg_faculty_audit_before;

CREATE OR REPLACE TRIGGER trg_faculty_audit_before
BEFORE INSERT OR UPDATE OR DELETE ON FACULTY
DECLARE
    v_action VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_action := 'INSERT';
    ELSIF UPDATING THEN
        v_action := 'UPDATE';
    ELSIF DELETING THEN
        v_action := 'DELETE';
    END IF;

    DBMS_OUTPUT.PUT_LINE(v_action);
END;
/

insert into FACULTY 
values ('ИИИ', 'И и и ИИ');

update FACULTY 
set FACULTY_NAME = 'ИИИИИИИ'
where FACULTY = 'ИИИ';

delete FROM FACULTY where FACULTY = 'ИИИ';

--  Task 2
drop TRIGGER trg_faculty_before_actions;

CREATE OR REPLACE TRIGGER trg_faculty_before_actions
BEFORE INSERT OR UPDATE OR DELETE ON FACULTY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.FACULTY_NAME IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Название факультета не может быть пустым.');
        END IF;

    ELSIF UPDATING THEN
        IF :NEW.FACULTY_NAME = :OLD.FACULTY_NAME THEN
            RAISE_APPLICATION_ERROR(-20002, 'Название факультета должно быть изменено при обновлении.');
        END IF;

    ELSIF DELETING THEN
        IF :OLD.FACULTY = 'ИИИ' THEN
            RAISE_APPLICATION_ERROR(-20003, 'Факультет ИИИ нельзя удалить.');
        END IF;
    END IF;
END;
/

insert into FACULTY 
values ('ИИИ', '');
insert into FACULTY 
values ('ИИИ', 'И и и ИИ');

update FACULTY 
set FACULTY_NAME = 'И и и ИИ'
where FACULTY = 'ИИИ';

delete FROM FACULTY where FACULTY = 'ИИИ';

--  Task 3
drop TRIGGER trg_faculty_audit_after;

CREATE OR REPLACE TRIGGER trg_faculty_audit_after
AFTER INSERT OR UPDATE OR DELETE ON FACULTY
DECLARE
    v_action VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_action := 'INSERT';
    ELSIF UPDATING THEN
        v_action := 'UPDATE';
    ELSIF DELETING THEN
        v_action := 'DELETE';
    END IF;

    DBMS_OUTPUT.PUT_LINE(v_action);
END;
/

insert into FACULTY 
values ('ИИИ', 'И и и ИИ');

update FACULTY 
set FACULTY_NAME = 'ИИИИИИИ'
where FACULTY = 'ИИИ';

delete FROM FACULTY where FACULTY = 'ИИИ';

--  Task 4
drop TRIGGER trg_faculty_before_actions_after;

CREATE OR REPLACE TRIGGER trg_faculty_before_actions_after
AFTER INSERT OR UPDATE OR DELETE ON FACULTY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.FACULTY_NAME = 'hello' THEN
            DBMS_OUTPUT.PUT_LINE('ФФФ говорит привет');
        END IF;

    ELSIF UPDATING THEN
        IF :NEW.FACULTY_NAME = 'byby' THEN
            DBMS_OUTPUT.PUT_LINE('ФФФ теперь говорит пока');
        END IF;

    ELSIF DELETING THEN
        IF :OLD.FACULTY = 'ФФФ' THEN
            RAISE_APPLICATION_ERROR(-20003, 'Факультет ФФФ нельзя удалить.');
        END IF;
    END IF;
END;
/

insert into FACULTY 
values ('ФФФ', 'hello');

update FACULTY 
set FACULTY_NAME = 'byby'
where FACULTY = 'ФФФ';

delete FROM FACULTY where FACULTY = 'ФФФ';

--  Task 5
create table Audits (
    OperationDate varchar2(25), 
    OperationType varchar2(30),
    TriggerName varchar2(100),
    data_change varchar2(250)
    );
-- drop table Audits;

CREATE OR REPLACE TRIGGER trg_faculty_audit_before
AFTER INSERT OR UPDATE OR DELETE ON FACULTY
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO AUDITS (OperationDate, OperationType, TriggerName, data_change)
        VALUES (TO_CHAR(SYSDATE, 'DD-MM-YYYY'), 'INSERT', 'trg_faculty_audit_before', 'New data = ' || :NEW.FACULTY);
    ELSIF UPDATING THEN
        INSERT INTO AUDITS (OperationDate, OperationType, TriggerName, data_change)
        VALUES (TO_CHAR(SYSDATE, 'DD-MM-YYYY'), 'UPDATE', 'trg_faculty_audit_before', 'Old data = ' || :OLD.FACULTY_NAME || ', New data = ' || :NEW.FACULTY_NAME);
    ELSIF DELETING THEN
        INSERT INTO AUDITS (OperationDate, OperationType, TriggerName, data_change)
        VALUES (TO_CHAR(SYSDATE, 'DD-MM-YYYY'), 'DELETE', 'trg_faculty_audit_before', 'Old data = ' || :OLD.FACULTY);
    END IF;
END;
/

begin
    select * from Audits;
end;
--  Task 6
begin 
    insert PULPIT values('hello', 'hello', 'hello')
end;

--  Task 7
begin
    drop table FACULTY;
end;

--  Task 8
create table Testing (id number, hello varchar2(200));

CREATE OR REPLACE TRIGGER DROP_CANSLE
BEFORE DROP ON U1_SNE_PDB.schema
BEGIN
    IF LOWER(DICTIONARY_OBJ_NAME) = 'testing' THEN
        RAISE_APPLICATION_ERROR(-20000, 'Вы не можете удалитьтаблицу Testing.');
    END IF;
END;
/

drop TRIGGER DROP_CANSLE;

DROP TABLE Testing;

-- Task 9
CREATE VIEW Testing_View AS SELECT * FROM Testing;
DROP VIEW Testing_View;

CREATE OR REPLACE TRIGGER INSTEADOF_INSERT_TRIGGER
INSTEAD OF INSERT ON Testing_View
BEGIN
    DBMS_OUTPUT.PUT_LINE('INSTEADOF_INSERT_TRIGGER');
    INSERT INTO  MY_TABLE (id, hello) 
    VALUES (:NEW.id, :NEW.hello);
END;
/

show errors;

INSERT INTO Testing_View VALUES (27, 'Valera');

SELECT * FROM Testing_View;
SELECT * FROM Testing;