--ALTER PLUGGABLE DATABASE SNE_PDB OPEN;
-- Task 1
BEGIN
    NULL;
END;

-- Task 2
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello world');
END;

-- Task 3
DECLARE
    x NUMBER(3) := 1;
    y NUMBER(3) := 1;
    z NUMBER(10, 2);
BEGIN
    z := x/y;
    DBMS_OUTPUT.PUT_LINE('z = ' || z);
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlcode || ': error = ' || sqlerrm);
END;

-- Task 4
DECLARE
    x NUMBER(3) := 1;
    y NUMBER(3) := 0;
    z NUMBER(10, 2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('x = ' || x || '; y = ' || y);
    BEGIN
        z := x/y;
    EXCEPTION
        WHEN OTHERS
            then DBMS_OUTPUT.PUT_LINE('error = ' || sqlerrm);
    END;
END;

-- Task 5
--show parameter PLSQL_WARNINGS;
select name, VALUE
from v$parameter;

-- Task 6
SELECT KEYWORD
FROM V$RESERVED_WORDS
WHERE LENGTH = 1;

-- Task 7
SELECT KEYWORD
FROM V$RESERVED_WORDS
WHERE LENGTH > 1
ORDER BY KEYWORD;

-- Task 8
--show parameter plsql;
SELECT name, value
FROM v$parameter
WHERE name like 'plsql%';

-- Task 9-17
DECLARE
    t1 NUMBER(3) := 10;
    t2 NUMBER(3) := 3;
    
    a1 NUMBER(3);
    a2 NUMBER(3);
    a3 NUMBER(3);
    a4 NUMBER(5, 2);
    a5 NUMBER(3);

    f NUMBER(10, 3) := 12.55;
    m NUMBER(10, -3) := 1234567.8910;

    bin BINARY_FLOAT := 123456.123456;
    doubl BINARY_DOUBLE := 9876.9876;

    eNum NUMBER(20, 5) := 12E+10;

    bo BOOLEAN := false;
BEGIN
    a1 := t1 + t2;
    a2 := t1 - t2;
    a3 := t1 * t2;
    a4 := t1 / t2;
    a5 := MOD(t1, t2);

    DBMS_OUTPUT.PUT_LINE(t1 || ' + ' || t2 || ' = ' || a1);
    DBMS_OUTPUT.PUT_LINE(t1 || ' - ' || t2 || ' = ' || a2);
    DBMS_OUTPUT.PUT_LINE(t1 || ' * ' || t2 || ' = ' || a3);
    DBMS_OUTPUT.PUT_LINE(t1 || ' / ' || t2 || ' = ' || a4);
    DBMS_OUTPUT.PUT_LINE(t1 || ' % ' || t2 || ' = ' || a5);
    DBMS_OUTPUT.PUT_LINE('f = ' || f);
    DBMS_OUTPUT.PUT_LINE('m = ' || m);
    DBMS_OUTPUT.PUT_LINE('float = ' || bin);
    DBMS_OUTPUT.PUT_LINE('double = ' || doubl);
    DBMS_OUTPUT.PUT_LINE('E with number = ' || eNum);
    
    if bo
    THEN
        DBMS_OUTPUT.PUT_LINE('bool = true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('bool = false');
    end if;
END;

-- Task 18
DECLARE
    numb CONSTANT NUMBER := 34;
    varcha CONSTANT VARCHAR2(10) := 'hello';
    cah char(15) := 'hello';
BEGIN
    cah := 'world';
    --varcha := 'world';
    DBMS_OUTPUT.PUT_LINE(numb);
    DBMS_OUTPUT.PUT_LINE(varcha);
    DBMS_OUTPUT.PUT_LINE(cah);
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('error = ' || sqlerrm);
END;

-- Task 19
-- DROP TABLE TestTable;
CREATE TABLE TestTable (x NUMBER(2), y varchar2(20));

DECLARE
    p U1_SNE_PDB.TestTable.y%type;
BEGIN
    p := 'Priv';
    DBMS_OUTPUT.PUT_LINE(p);
END;

-- Task 20
DECLARE
    func U1_SNE_PDB.TestTable%rowtype;
BEGIN
    func.x := 5;
    func.y := 'hello';

    DBMS_OUTPUT.PUT_LINE('x = ' || func.x || '; y = ' || func.y);
END;

-- Task 24
DECLARE
    X NUMBER(2) := 0;
BEGIN
    LOOP
        EXIT WHEN X > 10;
        DBMS_OUTPUT.PUT_LINE(X);
        X := X + 1;
    END LOOP;
END;

-- Task 21-22, 25
DECLARE
    x NUMBER(2) := 4;
BEGIN
    WHILE X < 7
        LOOP
        DBMS_OUTPUT.PUT_LINE(x);
        IF x < 5 THEN
            DBMS_OUTPUT.PUT_LINE('less then 5');
        ELSIF x > 5 THEN
            DBMS_OUTPUT.PUT_LINE('more then 5');
        ELSE
            DBMS_OUTPUT.PUT_LINE('== 5');
        END IF;
        x := x + 1;
        END LOOP;
END;

-- Task 23, 26
DECLARE
    x NUMBER(2) := 9;
BEGIN
    FOR i IN 0 .. 2 LOOP
        DBMS_OUTPUT.PUT_LINE(x);
        CASE
            WHEN x BETWEEN 0 and 9 THEN
                DBMS_OUTPUT.PUT_LINE('less then 10');
            WHEN x BETWEEN 11 and 20 THEN
                DBMS_OUTPUT.PUT_LINE('more then 10');
            ELSE
                DBMS_OUTPUT.PUT_LINE('== 10');
            END CASE;
        x := x + 1;
    END LOOP;
END;
