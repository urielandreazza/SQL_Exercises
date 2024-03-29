/*Data Insertion*/

/*
File:               UrielAssignment2.sql
Author:             Uriel Andreazza
Oracle Username:    S11_andreazz
Description:        Insert the Information Into the Specialty Import Tables
*/
SET LINESIZE 132
SET PAGESIZE 255

INSERT INTO s11.customer (
    custname
    ,custstreet
    ,custcity
    ,custprovince
    ,custpostal
    ,custhphone
    ,custbphone
) VALUES (
    'Uriel Andreazza'
    ,'1360, White Oaks Blv'
    ,'Oakville'
    ,'ON'
    ,'L6H2R7'
    ,'(555)111-222'
    ,'(555)111-222'
);

INSERT INTO s11.customer (
    custname
    ,custstreet
    ,custcity
    ,custprovince
    ,custpostal
    ,custhphone
    ,custbphone
) VALUES (
    'Gabriel Duarte'
    ,'1500, Malrborough St'
    ,'Oakville'
    ,'ON'
    ,'L6h 2R7'
    ,'(444)242-666'
    ,'(555)666-242'
);

INSERT INTO s11.purchinv (
    purchinvno
    ,purchfrom
    ,purchdate
) VALUES (
    'ABCDEF'
    ,'Wholesaler'
    ,'01-JAN-19'
);

INSERT INTO s11.car (
    carserial
    ,custname
    ,carmake
    ,carmodel
    ,caryear
    ,extcolor
    ,cartrim
    ,enginetype
    ,purchinvno
    ,purchcost
    ,freightcost
    ,carlistprice
) VALUES (
    'A17BAAA9'
    ,'Uriel Andreazza'
    ,'ACURA'
    ,'ILX'
    ,'2017'
    ,'Black'
    ,'TLX'
    ,'ELETRIC'
    ,NULL
    ,NULL
    ,NULL
    ,NULL
);

INSERT INTO s11.car (
    carserial
    ,custname
    ,carmake
    ,carmodel
    ,caryear
    ,extcolor
    ,cartrim
    ,enginetype
    ,purchinvno
    ,purchcost
    ,freightcost
    ,carlistprice
) VALUES (
    'A16WMDX9'
    ,'Gabriel Duarte'
    ,'ACURA'
    ,'MDX'
    ,'2016'
    ,'WHITE'
    ,'MDX'
    ,'GAS'
    ,NULL
    ,NULL
    ,NULL
    ,NULL
);

INSERT INTO s11.car (
    carserial
    ,custname
    ,carmake
    ,carmodel
    ,caryear
    ,extcolor
    ,cartrim
    ,enginetype
    ,purchinvno
    ,purchcost
    ,freightcost
    ,carlistprice
) VALUES (
    'J19RFPC1'
    ,NULL
    ,'JAGUAR'
    ,'F-PACE'
    ,'2019'
    ,'RED'
    ,'XJ'
    ,'GAS'
    ,'P12345'
    ,40000
    ,500
    ,45600
);

INSERT INTO s11.saleinv (
    saleinvno
    ,saledate
    ,salesman
    ,custname
    ,carserial
    ,insfire
    ,inscollision
    ,insliability
    ,taxrate
    ,licfee
    ,discount
    ,commission
    ,carsaleprice
) VALUES (
    'I'
    || TO_CHAR(s11.saleinv_seq.nextval,'FM00000')
    ,'02-JAN-19'
    ,'CHUCK BARTOWSKI'
    ,'Uriel Andreazza'
    ,'J19RFPC1'
    ,'Y'
    ,'Y'
    ,'Y'
    ,13
    ,100
    ,0
    ,( 0.10 * 45600 )
    ,45600
);

UPDATE s11.car
SET
    custname = 'URIEL ANDREAZZA'
WHERE
    carserial = 'J19RFPC1';

UPDATE s11.car
SET
    custname = 'URIEL ANDREAZZA'
WHERE
    carserial = 'A17BAAA9';

INSERT INTO s11.tradeinv (
    saleinvno
    ,carserial
    ,tradeallow
) VALUES (
    'I'
    || TO_CHAR(s11.saleinv_seq.currval,'FM00000')
    ,'A17BAAA9'
    ,5000
);

INSERT INTO s11.purchinv (
    purchinvno
    ,purchfrom
    ,purchdate
) VALUES (
    'I'
    || TO_CHAR(s11.saleinv_seq.currval,'FM00000')
    ,'Uriel Andreazza'
    ,'02-JAN-19'
);

INSERT INTO s11.invoption (
    saleinvno
    ,optioncode
    ,optionprice
) VALUES (
    'I'
    || TO_CHAR(s11.saleinv_seq.currval,'FM00000')
    ,'ED3'
    ,500
);

INSERT INTO s11.invoption (
    saleinvno
    ,optioncode
    ,optionprice
) VALUES (
    'I'
    || TO_CHAR(s11.saleinv_seq.currval,'FM00000')
    ,'D23'
    ,200
);

INSERT INTO s11.prospect (
    custname
    ,carmake
) VALUES (
    'Uriel Andreazza'
    ,'ACURA'
);

INSERT INTO s11.prospect (
    custname
    ,carmake
) VALUES (
    'Uriel Andreazza'
    ,'JAGUAR'
);

INSERT INTO s11.servinv (
    servinvno
    ,servdate
    ,custname
    ,carserial
    ,partscost
    ,laborcost
    ,taxrate
) VALUES (
    'W'
    || TO_CHAR(s11.servinv_seq.nextval,'FM0000')
    ,'02-JAN-19'
    ,'Gabriel Duarte'
    ,'A16WMDX9'
    ,500
    ,250
    ,13
);

INSERT INTO s11.servwork (
    servinvno
    ,workdesc
) VALUES (
    'W'
    || TO_CHAR(s11.servinv_seq.currval,'FM0000')
    ,'Changed oil, checked brakes and did car things'
);

INSERT INTO s11.servinv (
    servinvno
    ,servdate
    ,custname
    ,carserial
    ,partscost
    ,laborcost
    ,taxrate
) VALUES (
    'W'
    || TO_CHAR(s11.servinv_seq.nextval,'FM0000')
    ,'02-JAN-19'
    ,'Gabriel Duarte'
    ,'A16WMDX9'
    ,250
    ,75
    ,13
);

INSERT INTO s11.servwork (
    servinvno
    ,workdesc
) VALUES (
    'W'
    || TO_CHAR(s11.servinv_seq.currval,'FM0000')
    ,'Balanced the tires, and fixed the windowns'
);


COMMIT;

/*
---------------------- output results <-> start ------------------------
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row updated.
1 row updated.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
Commit complete.
---------------------- output results <-> end ------------------------ */