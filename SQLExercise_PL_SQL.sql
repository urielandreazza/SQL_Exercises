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

/*
File:               UrielAndreazzaAssignment7.sql
Author:             Uriel Andreazza
Oracle Username:    S11_andreazz
Description:        PL/SQL;
*/

/*#1 List the owners of a specific Model, Maker and Year*/

/*SELECT * FROM s11.car;*/
SET SERVEROUTPUT ON
ACCEPT p_make PROMPT 'Enter a Car Maker: ';
ACCEPT p_model PROMPT 'Enter a Car Model: ';
ACCEPT p_year PROMPT 'Enter a Car Year: '; 

DECLARE
    v_make     VARCHAR2(50) := '&p_make';
    v_model    VARCHAR2(50) := '&p_model';
    v_year     VARCHAR2(50) := '&p_year';
    v_name     customer.custname%TYPE;
    v_street   customer.custstreet%TYPE;
    v_city     customer.custcity%TYPE;
    v_province customer.custprovince%TYPE;
    v_postal   customer.custpostal%TYPE;
    
CURSOR car_cur IS 
    SELECT
       c.custname
      ,c.custstreet
      ,c.custcity
      ,c.custprovince
      ,c.custpostal
    FROM
      s11.customer c
    LEFT JOIN 
      s11.car c1 
    ON 
      c1.custname = c.custname
    WHERE
      UPPER(c1.carmake) = UPPER(v_make)
      AND UPPER(c1.carmodel) = UPPER(v_model)
      AND UPPER(c1.caryear) = UPPER(v_year);
BEGIN
      dbms_output.put_line(v_make||CHR(9)||v_model||CHR(13)||v_year||CHR(13)||CHR(13));
      OPEN car_cur;
      LOOP
        FETCH car_cur INTO v_name, v_street, v_city, v_province, v_postal;
        EXIT WHEN car_cur%NOTFOUND;
        dbms_output.put_line(v_name||CHR(13)||v_street||CHR(13)||v_city||CHR(9)||v_province||CHR(9)||v_postal||CHR(13)||CHR(13));
      END LOOP;
      CLOSE car_cur;
      
END;
/ 
/*
---------------------- output results <-> start ------------------------

old:DECLARE
    v_make     VARCHAR2(50) := '&p_make';
    v_model    VARCHAR2(50) := '&p_model';
    v_year     VARCHAR2(50) := '&p_year';
    v_name     customer.custname%TYPE;
    v_street   customer.custstreet%TYPE;
    v_city     customer.custcity%TYPE;
    v_province customer.custprovince%TYPE;
    v_postal   customer.custpostal%TYPE;

CURSOR car_cur IS 
    SELECT
       c.custname
      ,c.custstreet
      ,c.custcity
      ,c.custprovince
      ,c.custpostal
    FROM
      s11.customer c
    LEFT JOIN 
      s11.car c1 
    ON 
      c1.custname = c.custname
    WHERE
      UPPER(c1.carmake) = UPPER(v_make)
      AND UPPER(c1.carmodel) = UPPER(v_model)
      AND UPPER(c1.caryear) = UPPER(v_year);
BEGIN
      dbms_output.put_line(v_make||CHR(9)||v_model||CHR(13)||v_year||CHR(13)||CHR(13));
      OPEN car_cur;
      LOOP
        FETCH car_cur INTO v_name, v_street, v_city, v_province, v_postal;
        EXIT WHEN car_cur%NOTFOUND;
        dbms_output.put_line(v_name||CHR(13)||v_street||CHR(13)||v_city||CHR(9)||v_province||CHR(9)||v_postal||CHR(13)||CHR(13));
      END LOOP;
      CLOSE car_cur;

END;

new:DECLARE
    v_make     VARCHAR2(50) := 'toyota';
    v_model    VARCHAR2(50) := 'corolla';
    v_year     VARCHAR2(50) := '2017';
    v_name     customer.custname%TYPE;
    v_street   customer.custstreet%TYPE;
    v_city     customer.custcity%TYPE;
    v_province customer.custprovince%TYPE;
    v_postal   customer.custpostal%TYPE;

CURSOR car_cur IS 
    SELECT
       c.custname
      ,c.custstreet
      ,c.custcity
      ,c.custprovince
      ,c.custpostal
    FROM
      s11.customer c
    LEFT JOIN 
      s11.car c1 
    ON 
      c1.custname = c.custname
    WHERE
      UPPER(c1.carmake) = UPPER(v_make)
      AND UPPER(c1.carmodel) = UPPER(v_model)
      AND UPPER(c1.caryear) = UPPER(v_year);
BEGIN
      dbms_output.put_line(v_make||CHR(9)||v_model||CHR(13)||v_year||CHR(13)||CHR(13));
      OPEN car_cur;
      LOOP
        FETCH car_cur INTO v_name, v_street, v_city, v_province, v_postal;
        EXIT WHEN car_cur%NOTFOUND;
        dbms_output.put_line(v_name||CHR(13)||v_street||CHR(13)||v_city||CHR(9)||v_province||CHR(9)||v_postal||CHR(13)||CHR(13));
      END LOOP;
      CLOSE car_cur;

END;
toyota	corolla
2017

MICHAEL PUNDHIR
1717 Link Road
Etobicoke	ON	K7S7H1 

SHAYNE DOE
321 Fake Street
Mississauga	ON	L5E 4J4

AJ CLEMENTE
1111 COLLEGE DRIVE
MISSISSAUGA	ON	L5L 3Z5

MILES
SPEERS RD.
OAKVILLE	ON	L6H2H6 

PETER SHERMAN
42 Wallaby Way
Sydney	NS	N7R 1E4



PL/SQL procedure successfully completed.


---------------------- output results <-> end ------------------------ */
/*#2 List the Average per car model (diferentiate when there was none or one sold)*/
SET SERVEROUTPUT ON
ACCEPT p_make2 PROMPT 'Enter a Car Maker: ';
ACCEPT p_model2 PROMPT 'Enter a Car Model: ';
DECLARE
    v_make     VARCHAR2(50) := '&p_make2';
    v_model    VARCHAR2(50) := '&p_model2';
    v_average    NUMBER;
    v_count    NUMBER;
    e_single_record EXCEPTION;
    e_no_record EXCEPTION;
BEGIN
    SELECT 
        COUNT(*)
       ,SUM(s.carsaleprice)
    INTO 
        v_count
       ,v_average 
    FROM 
        s11.saleinv s
    LEFT JOIN
        s11.car c
    ON
        UPPER(c.carserial) = UPPER(s.carserial)
    WHERE 
        UPPER(c.carmake) = UPPER(v_make)
    AND 
        UPPER(c.carmodel) = UPPER(v_model)
    AND
        s.custname IS NOT NULL;
    
    /* user defined exception to */
    IF v_count = 0 THEN
        RAISE e_no_record;
    ELSIF v_count = 1 THEN
        RAISE e_single_record;
    ELSE
        dbms_output.put_line(v_count||CHR(9)||v_make||' cars model '||v_model||' were sold for an average of: '||TO_CHAR(v_average/v_count,'99999.99'));
    END IF;


EXCEPTION
    WHEN e_no_record THEN
        dbms_output.put_line('No Car Sold');
    WHEN e_single_record THEN
        dbms_output.put_line('Single car Sold for: '|| TO_CHAR(v_average,'9999.99'));
END;
/ 



/*
---------------------- output results <-> start ------------------------
old:DECLARE
    v_make     VARCHAR2(50) := '&p_make2';
    v_model    VARCHAR2(50) := '&p_model2';
    v_average    NUMBER;
    v_count    NUMBER;
    e_single_record EXCEPTION;
    e_no_record EXCEPTION;
BEGIN
    SELECT 
        COUNT(*)
       ,SUM(s.carsaleprice)
    INTO 
        v_count
       ,v_average 
    FROM 
        s11.saleinv s
    LEFT JOIN
        s11.car c
    ON
        UPPER(c.carserial) = UPPER(s.carserial)
    WHERE 
        UPPER(c.carmake) = UPPER(v_make)
    AND 
        UPPER(c.carmodel) = UPPER(v_model)
    AND
        s.custname IS NOT NULL;

    
    IF v_count = 0 THEN
        RAISE e_no_record;
    ELSIF v_count = 1 THEN
        RAISE e_single_record;
    ELSE
        dbms_output.put_line(v_count||CHR(9)||v_make||' cars model '||v_model||' were sold for an average of: '||TO_CHAR(v_average/v_count,'99999.99'));
    END IF;


EXCEPTION
    WHEN e_no_record THEN
        dbms_output.put_line('No Car Sold');
    WHEN e_single_record THEN
        dbms_output.put_line('Single car Sold for: '|| TO_CHAR(v_average,'9999.99'));
END;

new:DECLARE
    v_make     VARCHAR2(50) := 'mercedes';
    v_model    VARCHAR2(50) := 'c300';
    v_average    NUMBER;
    v_count    NUMBER;
    e_single_record EXCEPTION;
    e_no_record EXCEPTION;
BEGIN
    SELECT 
        COUNT(*)
       ,SUM(s.carsaleprice)
    INTO 
        v_count
       ,v_average 
    FROM 
        s11.saleinv s
    LEFT JOIN
        s11.car c
    ON
        UPPER(c.carserial) = UPPER(s.carserial)
    WHERE 
        UPPER(c.carmake) = UPPER(v_make)
    AND 
        UPPER(c.carmodel) = UPPER(v_model)
    AND
        s.custname IS NOT NULL;

    
    IF v_count = 0 THEN
        RAISE e_no_record;
    ELSIF v_count = 1 THEN
        RAISE e_single_record;
    ELSE
        dbms_output.put_line(v_count||CHR(9)||v_make||' cars model '||v_model||' were sold for an average of: '||TO_CHAR(v_average/v_count,'99999.99'));
    END IF;


EXCEPTION
    WHEN e_no_record THEN
        dbms_output.put_line('No Car Sold');
    WHEN e_single_record THEN
        dbms_output.put_line('Single car Sold for: '|| TO_CHAR(v_average,'9999.99'));
END;
3	mercedes cars model c300 were sold for an average of:  93898.30


PL/SQL procedure successfully completed.







---------------------- output results <-> end ------------------------ */