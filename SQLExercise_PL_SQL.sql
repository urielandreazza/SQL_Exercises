/*
File:               UrielAndreazzaAssignment6.sql
Author:             Uriel Andreazza
Oracle Username:    S11_andreazz
Description:        PL/SQL;
*/

/*#1 Accept a Saleman Name, Query the Table and return a String with the amount of cars sold */
ACCEPT p_salesman PROMPT 'Enter Salesman name: ';
DECLARE
   v_salesman VARCHAR2(50) := '&p_salesman';
   v_count NUMBER;
   v_message varchar2(50);
BEGIN 
    SELECT COUNT(salesman)
    INTO v_count
    FROM s11.saleinv
    WHERE UPPER(salesman) = UPPER(v_salesman);
 
    IF v_count = 0 THEN
        v_message := v_salesman ||' has sold no cars';
    ELSIF v_count = 1 THEN
        v_message := v_salesman ||' has sold one car';
    ELSE
        v_message := v_salesman ||' has sold '|| v_count ||' cars';
    END IF;
 
        dbms_output.put_line(v_message);
END;
/ 

/*
---------------------- output results <-> start ------------------------
:::DBMS_OUTPUT.PUT_LINE:::

DEADBEAT DAN has sold 40 cars

::SCRIPT OUTPUT::

old:DECLARE
   v_salesman VARCHAR2(50) := '&p_salesman';
   v_count NUMBER;
   v_message varchar2(50);
BEGIN 
    SELECT COUNT(salesman)
    INTO v_count
    FROM s11.saleinv
    WHERE UPPER(salesman) = UPPER(v_salesman);

    IF v_count = 0 THEN
        v_message := v_salesman ||' has sold no cars';
    ELSIF v_count = 1 THEN
        v_message := v_salesman ||' has sold one car';
    ELSE
        v_message := v_salesman ||' has sold '|| v_count ||' cars';
    END IF;

        dbms_output.put_line(v_message);
END;

new:DECLARE
   v_salesman VARCHAR2(50) := 'DEADBEAT DAN';
   v_count NUMBER;
   v_message varchar2(50);
BEGIN 
    SELECT COUNT(salesman)
    INTO v_count
    FROM s11.saleinv
    WHERE UPPER(salesman) = UPPER(v_salesman);

    IF v_count = 0 THEN
        v_message := v_salesman ||' has sold no cars';
    ELSIF v_count = 1 THEN
        v_message := v_salesman ||' has sold one car';
    ELSE
        v_message := v_salesman ||' has sold '|| v_count ||' cars';
    END IF;

        dbms_output.put_line(v_message);
END;

PL/SQL procedure successfully completed.



---------------------- output results <-> end ------------------------ */

/*#2 Accept a saleinv number and print all the Required fields */

ACCEPT p_servinvno PROMPT 'Enter Service Invoice Number name: ';
DECLARE
   v_servinvno VARCHAR2(50) := '&p_servinvno';
   v_workdesc VARCHAR2(50);
   v_servdate VARCHAR2(50);
   v_custname VARCHAR2(50);
   v_carserial VARCHAR2(50);
   v_partcost NUMBER;
   v_laborcost NUMBER;
   v_taxrate NUMBER;
   v_totalpay NUMBER;
   v_message varchar2(600);
BEGIN 
    SELECT servdate, custname, carserial, partscost, laborcost, taxrate
    INTO v_servdate,v_custname, v_carserial, v_partcost, v_laborcost, v_taxrate
    FROM S11.servinv
    WHERE UPPER(servinvno) = UPPER(v_servinvno);
 
    SELECT workdesc
    INTO v_workdesc
    FROM S11.servwork
    WHERE UPPER(servinvno) = UPPER(v_servinvno);
 
    v_totalpay := ((v_partcost+v_laborcost)*(1+(v_taxrate/100)));
 
    v_message := 'Invoice no:       '||v_servinvno || CHR(13)
               ||'Service Date:     '||v_servdate || CHR(13)
               ||'Customer Name:    '||v_custname || CHR(13)
               ||'Car Serial:       '||v_carserial || CHR(13)
               ||'Work Description: '||v_workdesc || CHR(13)
               ||'Parts cost:       '||TO_CHAR(v_partcost,  '999.99') || CHR(13)
               ||'Labour cost:      '||TO_CHAR(v_laborcost, '999.99') || CHR(13)
               ||'Tax:              '||TO_CHAR((v_totalpay - v_laborcost - v_partcost),'999.99') || CHR(13)
               ||'------------------------------' || CHR(13)
               ||'Total Payable:    '||TO_CHAR(v_totalpay, '999.99');
 
        dbms_output.put_line(v_message);
END;
/ 

/*
---------------------- output results <-> start ------------------------
:::DBMS_OUTPUT.PUT_LINE:::

Invoice no:       W1822
Service Date:     18-07-25
Customer Name:    KAWALJIT KAUR
Car Serial:       H16GELA3
Work Description: ENGINE REPAIRATION
Parts cost:         45.00
Labour cost:        50.00
Tax:                12.35
------------------------------
Total Payable:     107.35



::SCRIPT OUTPUT::
old:DECLARE
   v_servinvno VARCHAR2(50) := '&p_servinvno';
   v_workdesc VARCHAR2(50);
   v_servdate VARCHAR2(50);
   v_custname VARCHAR2(50);
   v_carserial VARCHAR2(50);
   v_partcost NUMBER;
   v_laborcost NUMBER;
   v_taxrate NUMBER;
   v_totalpay NUMBER;
   v_message varchar2(600);
BEGIN 
    SELECT servdate, custname, carserial, partscost, laborcost, taxrate
    INTO v_servdate,v_custname, v_carserial, v_partcost, v_laborcost, v_taxrate
    FROM S11.servinv
    WHERE UPPER(servinvno) = UPPER(v_servinvno);

    SELECT workdesc
    INTO v_workdesc
    FROM S11.servwork
    WHERE UPPER(servinvno) = UPPER(v_servinvno);

    v_totalpay := ((v_partcost+v_laborcost)*(1+(v_taxrate/100)));

    v_message := 'Invoice no:       '||v_servinvno || CHR(13)
               ||'Service Date:     '||v_servdate || CHR(13)
               ||'Customer Name:    '||v_custname || CHR(13)
               ||'Car Serial:       '||v_carserial || CHR(13)
               ||'Work Description: '||v_workdesc || CHR(13)
               ||'Parts cost:       '||TO_CHAR(v_partcost,  '999.99') || CHR(13)
               ||'Labour cost:      '||TO_CHAR(v_laborcost, '999.99') || CHR(13)
               ||'Tax:              '||TO_CHAR((v_totalpay - v_laborcost - v_partcost),'999.99') || CHR(13)
               ||'------------------------------' || CHR(13)
               ||'Total Payable:    '||TO_CHAR(v_totalpay, '999.99');

        dbms_output.put_line(v_message);
END;

new:DECLARE
   v_servinvno VARCHAR2(50) := 'W1822';
   v_workdesc VARCHAR2(50);
   v_servdate VARCHAR2(50);
   v_custname VARCHAR2(50);
   v_carserial VARCHAR2(50);
   v_partcost NUMBER;
   v_laborcost NUMBER;
   v_taxrate NUMBER;
   v_totalpay NUMBER;
   v_message varchar2(600);
BEGIN 
    SELECT servdate, custname, carserial, partscost, laborcost, taxrate
    INTO v_servdate,v_custname, v_carserial, v_partcost, v_laborcost, v_taxrate
    FROM S11.servinv
    WHERE UPPER(servinvno) = UPPER(v_servinvno);

    SELECT workdesc
    INTO v_workdesc
    FROM S11.servwork
    WHERE UPPER(servinvno) = UPPER(v_servinvno);

    v_totalpay := ((v_partcost+v_laborcost)*(1+(v_taxrate/100)));

    v_message := 'Invoice no:       '||v_servinvno || CHR(13)
               ||'Service Date:     '||v_servdate || CHR(13)
               ||'Customer Name:    '||v_custname || CHR(13)
               ||'Car Serial:       '||v_carserial || CHR(13)
               ||'Work Description: '||v_workdesc || CHR(13)
               ||'Parts cost:       '||TO_CHAR(v_partcost,  '999.99') || CHR(13)
               ||'Labour cost:      '||TO_CHAR(v_laborcost, '999.99') || CHR(13)
               ||'Tax:              '||TO_CHAR((v_totalpay - v_laborcost - v_partcost),'999.99') || CHR(13)
               ||'------------------------------' || CHR(13)
               ||'Total Payable:    '||TO_CHAR(v_totalpay, '999.99');

        dbms_output.put_line(v_message);
END;

PL/SQL procedure successfully completed.


---------------------- output results <-> end ------------------------ */


/*#3 Change the Customer Table */

SELECT * FROM CUSTOMER;


ACCEPT p_oldName PROMPT 'Enter Existing Customer name: ';
ACCEPT p_newName PROMPT 'Enter New Customer name: ';

DECLARE
 v_oldName VARCHAR2(50) := '&p_oldName';
 v_newName VARCHAR2(50) := '&p_newName';
BEGIN

INSERT INTO customer
   (SELECT v_newName, custstreet, custcity, custprovince, custpostal, custhphone, custbphone
      FROM customer
     WHERE UPPER(custname) = UPPER(v_oldName));

UPDATE prospect
    SET custname = UPPER(v_newName)
WHERE UPPER(custname) = UPPER(v_oldName);
 
UPDATE servinv
   SET custname = UPPER(v_newName)
WHERE UPPER(custname) = UPPER(v_oldName);

UPDATE saleinv
   SET custname = UPPER(v_newName)
WHERE custname = UPPER(v_oldName);

UPDATE car
   SET custname = UPPER(v_newName)
WHERE custname = UPPER(v_oldName);

DELETE FROM customer
 WHERE UPPER(custname) = UPPER(v_oldName);

END;
/


/*
---------------------- output results <-> start ------------------------
old:DECLARE
 v_oldName VARCHAR2(50) := '&p_oldName';
 v_newName VARCHAR2(50) := '&p_newName';
BEGIN

INSERT INTO customer
   (SELECT v_newName, custstreet, custcity, custprovince, custpostal, custhphone, custbphone
      FROM customer
     WHERE UPPER(custname) = UPPER(v_oldName));


UPDATE prospect
    SET custname = UPPER(v_newName)
WHERE UPPER(custname) = UPPER(v_oldName);

UPDATE servinv
   SET custname = UPPER(v_newName)
WHERE UPPER(custname) = UPPER(v_oldName);

UPDATE saleinv
   SET custname = UPPER(v_newName)
WHERE custname = UPPER(v_oldName);

UPDATE car
   SET custname = UPPER(v_newName)
WHERE custname = UPPER(v_oldName);

DELETE FROM customer
 WHERE UPPER(custname) = UPPER(v_oldName);

END;

new:DECLARE
 v_oldName VARCHAR2(50) := 'CASEY PALMER';
 v_newName VARCHAR2(50) := 'IURI ANDREAZZA';
BEGIN

INSERT INTO customer
   (SELECT v_newName, custstreet, custcity, custprovince, custpostal, custhphone, custbphone
      FROM customer
     WHERE UPPER(custname) = UPPER(v_oldName));


UPDATE prospect
    SET custname = UPPER(v_newName)
WHERE UPPER(custname) = UPPER(v_oldName);

UPDATE servinv
   SET custname = UPPER(v_newName)
WHERE UPPER(custname) = UPPER(v_oldName);

UPDATE saleinv
   SET custname = UPPER(v_newName)
WHERE custname = UPPER(v_oldName);

UPDATE car
   SET custname = UPPER(v_newName)
WHERE custname = UPPER(v_oldName);

DELETE FROM customer
 WHERE UPPER(custname) = UPPER(v_oldName);

END;

PL/SQL procedure successfully completed.
---------------------- output results <-> end ------------------------ */