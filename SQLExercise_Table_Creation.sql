/* Table Creation */
/*
File:               UrielAndreazzaAssignment1.sql
Author:             Uriel Andreazza
Oracle Username:    S11_andreazz
Description:        This is Assignment 1 from class, in which we create the Specialty Import Tables
                    According to the Design provided.
*/
SET LINESIZE 132
SET PAGESIZE 255

/* Drop all the existing tables */

DROP TABLE prospect;
DROP TABLE servwork;
DROP TABLE servinv;
DROP TABLE invoption;
DROP TABLE tradeinv;
DROP TABLE saleinv;
DROP TABLE baseoption;
DROP TABLE car;
DROP TABLE purchinv;
DROP TABLE employee;
DROP TABLE options;
DROP TABLE customer;


/*Create the Tables */
CREATE TABLE customer (
    custname       VARCHAR2(20)
    ,custstreet     VARCHAR2(20) NOT NULL
    ,custcity       VARCHAR2(20)
    ,custprovince   CHAR(2) DEFAULT 'ON'
    ,custopostal    CHAR(7) NOT NULL
    ,custhphone     CHAR(13) NOT NULL
    ,custbphone     CHAR(13) NOT NULL
    ,CONSTRAINT customer_pk PRIMARY KEY ( custname )
);

CREATE TABLE options (
    optioncode        CHAR(4)
    ,optiondesc        VARCHAR2(30)
    ,optioncost        NUMBER(7,2)
    ,optionlistprice   NUMBER(7,2)
    ,CONSTRAINT options_pk PRIMARY KEY ( optioncode )
);

CREATE TABLE employee (
    empname         VARCHAR2(20)
    ,startdate       DATE NOT NULL
    ,comissionrate   NUMBER(3,1)
    ,title           VARCHAR2(26)
    /* manager is a reserved word */
    ,empmanager      VARCHAR2(20)
    ,CONSTRAINT employee_pk PRIMARY KEY ( empname )
    ,CONSTRAINT employee_manager_fk FOREIGN KEY ( empmanager )
        REFERENCES employee ( empname )
);

CREATE TABLE purchinv (
    purchinvno   CHAR(6)
    ,purchfrom    VARCHAR2(15)
    ,purchdate    DATE
    ,CONSTRAINT purchinv_pk PRIMARY KEY ( purchinvno )
);

CREATE TABLE car (
    carserial      CHAR(8)
    ,custname       VARCHAR2(20)
    ,carmake        VARCHAR2(10) NOT NULL CHECK ( carmake IN (
        'ACURA'
        ,'MERCEDES'
        ,'LAND ROVER'
        ,'JAGUAR'
    ) )
    ,carmodel       VARCHAR2(10) NOT NULL
    ,caryear        CHAR(4) NOT NULL
    ,extcolour      VARCHAR2(12) NOT NULL
    ,cartrim        VARCHAR2(16) NOT NULL
    ,enginetype     VARCHAR2(10) NOT NULL
    ,purchinvno     CHAR(6)
    ,purchcost      NUMBER(9,2)
    ,freightcost    NUMBER(9,2)
    ,carlistprice   NUMBER(9,2)
    ,CONSTRAINT car_pk PRIMARY KEY ( carserial )
    ,CONSTRAINT car_customer_fk FOREIGN KEY ( custname )
        REFERENCES customer ( custname )
    ,CONSTRAINT car_purchase_inventory_fk FOREIGN KEY ( purchinvno )
        REFERENCES purchinv ( purchinvno )
);

CREATE TABLE baseoption (
    optioncode   CHAR(4)
    ,carserial    CHAR(8)
    ,CONSTRAINT baseoption_car_fk FOREIGN KEY ( carserial )
        REFERENCES car ( carserial )
    ,CONSTRAINT baseoption_option_fk FOREIGN KEY ( optioncode )
        REFERENCES options ( optioncode )
);

CREATE TABLE saleinv (
    saleinvno      CHAR(6)
    ,saledate       DATE NOT NULL CHECK ( saledate > TO_DATE('01-JAN-1990','DD-MON-YYYY') )
    ,salesman       VARCHAR2(20) NOT NULL
    ,custname       VARCHAR2(20) NOT NULL
    ,carserial      CHAR(8) NOT NULL
    ,insfire        CHAR(1) CHECK ( insfire IN (
        'Y'
        ,'N'
    ) )
    ,inscollision   CHAR(1) CHECK ( inscollision IN (
        'Y'
        ,'N'
    ) )
    ,insliability   CHAR(1) CHECK ( insliability IN (
        'Y'
        ,'N'
    ) )
    ,insproperty    CHAR(1) CHECK ( insproperty IN (
        'Y'
        ,'N'
    ) )
    ,taxrate        NUMBER(4,2) DEFAULT 13.0
    ,licfee         NUMBER(6,2)
    ,discount       NUMBER(8,2)
    ,comission      NUMBER(8,2)
    ,carsaleprice   NUMBER(9,2)
    ,CONSTRAINT saleinv_pk PRIMARY KEY ( saleinvno )
    ,CONSTRAINT saleinv_salesman_fk FOREIGN KEY ( salesman )
        REFERENCES employee ( empname )
    ,CONSTRAINT saleinv_customer_fk FOREIGN KEY ( custname )
        REFERENCES customer ( custname )
    ,CONSTRAINT saleinv_car_fk FOREIGN KEY ( carserial )
        REFERENCES car ( carserial )
);

CREATE TABLE tradeinv (
    saleinvno    CHAR(6)
    ,carserial    CHAR(8)
    ,tradeallow   NUMBER(9,2)
    ,CONSTRAINT tradeinv_sales_inventory_fk FOREIGN KEY ( saleinvno )
        REFERENCES saleinv ( saleinvno )
    ,CONSTRAINT tradeinv_car_fk FOREIGN KEY ( carserial )
        REFERENCES car ( carserial )
);

CREATE TABLE invoption (
    saleinvno     CHAR(6)
    ,optioncode    CHAR(4)
    ,optionprice   NUMBER(7,2)
    ,CONSTRAINT invoption_sales_inventory_fk FOREIGN KEY ( saleinvno )
        REFERENCES saleinv ( saleinvno )
    ,CONSTRAINT invoption_option_fk FOREIGN KEY ( optioncode )
        REFERENCES options ( optioncode )
);

CREATE TABLE servinv (
    servinvno    CHAR(5)
    ,servdate     DATE NOT NULL
    ,custname     VARCHAR2(20) NOT NULL
    ,carserial    CHAR(8) NOT NULL
    ,partsprice   NUMBER(7,2)
    ,laborprice   NUMBER(7,2)
    ,taxrate      NUMBER(4,2) DEFAULT 13.0
    ,CONSTRAINT servinv_pk PRIMARY KEY ( servinvno )
    ,CONSTRAINT servinv_customer_fk FOREIGN KEY ( custname )
        REFERENCES customer ( custname )
    ,CONSTRAINT servinv_car_fk FOREIGN KEY ( carserial )
        REFERENCES car ( carserial )
);

CREATE TABLE servwork (
    servinvno   CHAR(5)
    ,workdesc    VARCHAR2(80)
    ,CONSTRAINT servwork_service_inventory_fk FOREIGN KEY ( servinvno )
        REFERENCES servinv ( servinvno )
);

CREATE TABLE prospect (
    custname     VARCHAR2(20) NOT NULL
    ,carmake      VARCHAR2(10) NOT NULL
    ,carmodel     VARCHAR2(10)
    ,caryear      CHAR(4)
    ,carcolour    VARCHAR2(12)
    ,cartrim      VARCHAR2(16)
    ,optioncode   CHAR(4)
    ,CONSTRAINT prosptect_customer_fk FOREIGN KEY ( custname )
        REFERENCES customer ( custname )
    ,CONSTRAINT prosptect_option_fk FOREIGN KEY ( optioncode )
        REFERENCES options ( optioncode )
);

CREATE SEQUENCE saleinv_seq;

CREATE SEQUENCE servinv_seq;

/*
---------------------- output results <-> start ------------------------
Table PROSPECT dropped.
Table SERVWORK dropped.
Table SERVINV dropped.
Table INVOPTION dropped.
Table TRADEINV dropped.
Table SALEINV dropped.
Table BASEOPTION dropped.
Table CAR dropped.
Table PURCHINV dropped.
Table EMPLOYEE dropped.
Table OPTIONS dropped.
Table CUSTOMER dropped.
Table CUSTOMER created.
Table OPTIONS created.
Table EMPLOYEE created.
Table PURCHINV created.
Table CAR created.
Table BASEOPTION created.
Table SALEINV created.
Table TRADEINV created.
Table INVOPTION created.
Table SERVINV created.
Table SERVWORK created.
Table PROSPECT created.
Table PROSPECT dropped.
Table SERVWORK dropped.
Table SERVINV dropped.
Table INVOPTION dropped.
Table TRADEINV dropped.
Table SALEINV dropped.
Table BASEOPTION dropped.
Table CAR dropped.
Table PURCHINV dropped.
Table EMPLOYEE dropped.
Table OPTIONS dropped.
Table CUSTOMER dropped.
Table CUSTOMER created.
Table OPTIONS created.
Table EMPLOYEE created.
Table PURCHINV created.
Table CAR created.
Table BASEOPTION created.
Table SALEINV created.
Table TRADEINV created.
Table INVOPTION created.
Table SERVINV created.
Table SERVWORK created.
Table PROSPECT created.
Sequence SALEINV_SEQ created.
Sequence SERVINV_SEQ created.
---------------------- output results <-> end ------------------------ */