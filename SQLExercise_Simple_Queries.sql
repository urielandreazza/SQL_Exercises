 
 /* Simple Queries */
 /*#1 Count the Cars with no Insurance*/
SELECT
      COUNT(carserial) as "Cars with no insurance"
FROM
      s11.car
WHERE
        custname IN (
            SELECT
                custname
            FROM
               s11.saleinv
           WHERE
               ( insfire = 'N'
                 OR insfire = NULL )
               AND ( inscollision = 'N'
                     OR inscollision = NULL )
               AND ( insliability = 'N'
                     OR insliability = NULL )
               AND ( insproperty = 'N'
                    OR insproperty = NULL )
      );
/* ----->Output<-----
Cars with no insurance
----------------------
                    36
*/


 /*#2 Select the Customer information with the designated Option Type*/
 SELECT
        custname
        ,custcity
        ,custhphone
        ,custbphone
    FROM
        s11.customer
    WHERE
        custname IN (
           SELECT DISTINCT
               custname
           FROM
               s11.prospect
           WHERE
               optioncode = 'M14'
               OR optioncode = 'R14'
       );

/* ----->Output<-----
CUSTNAME             CUSTCITY             CUSTHPHONE    CUSTBPHONE   
-------------------- -------------------- ------------- -------------
YOGESH THAKUR        Mississauga          (647)633-7645 (757)255-7878
E LOMBARD            Oakville             (905)811-1234              
ZACHARY CRUMP        Nowhere                                         
ART KHLAMOV          Oakville             (098)563-8542 (905)333-7742
BRAYDON VAREY        Georgetown           (905)754-7845 (547)874-5488
KYLE GABET           Georgetown           (905)873-0191 (905)703-9191
MARY WHITE           BRAMPTON             (666)222-3333 (444)555-666 
STANLEY LEE          BRAMPTON             (905)874-4393 (905)839-5942
CARL EDWARDS         MISSISSAUGA          (416)882-1494              
ZAKEIR SAMSOODIN     MISSISSAUGA          (905)623-5332 (416)293-5332
TYRONE SAGARINO      MISSISSAUGA          (905)444-7777 (416)777-8888
DAMAN                MISSISSAUGA          (111)111-1111              
HADYA ADNAN          Hamilton             (905)924-1234 (905)678-3456
NIZETTE ROBAS        MISSISSAUGA          (905)111-1111 (416)222-2222
VICTOR               OAKVILLE             (416)423-4325 (905)432-5321
VIKKI WONG           MISSISSAUGA          (647)975-5000 (647)888-9999
SHANNON HAN          HUNDRED ACRE WOOD    (000)123-1234 (111)321-4321
JUNGAH PARK          Oakville             (905)123-4567 (289)813-0000
JOSH HOWSON          Georgetown           (905)703-1099 (647)299-4014

19 rows selected. 
*/
 
 /*#3 Select the customers who own an Acura model MDX*/
 SELECT
        custname
        ,custstreet
        ,custcity
        ,custprovince
        ,custpostal
    FROM
        s11.customer
    WHERE
       custname IN (
           SELECT
               custname
           FROM
               s11.car
           WHERE
               carmake = 'ACURA'
               AND carmodel = 'MDX'
               AND NOT ( purchinvno = NULL )
       );

/* ----->Output<-----
    no rows selected
*/


 /*#4 Select The Avg Cost of Service cost for Acuras*/
 SELECT
        ROUND(AVG(partscost + laborcost),2) AS "Average Service Cost"
    FROM
        s11.servinv
    WHERE
        carserial IN (
            SELECT
                carserial
            FROM
               s11.car
           WHERE
               carmake = 'ACURA'
       );

/* ----->Output<-----
Average Service Cost
--------------------
              652.06
*/
 
 /*#5 Select the Customer Information from Brampton who are selling cars*/
 SELECT
        custname
        ,custhphone
        ,custbphone
    FROM
        s11.customer
    WHERE
        custcity = 'Brampton'
        AND custname IN (
           SELECT DISTINCT
               custname
           FROM
               s11.saleinv
           WHERE
           carsaleprice > 0 
       );

/* ----->Output<-----
CUSTNAME             CUSTHPHONE    CUSTBPHONE   
-------------------- ------------- -------------
AUSTIN PEREIRA       (123)123-1234 (321)321-4321
CATHERINE OWUSU      (450)448-8843              
DEJAN P              (905)867-9431 (289)291-9001
ROBERT FILOSA        (905)842-5678 (905)765-4582
*/
 
 /*6 Select car information of the car with the highest Service Cost*/
 SELECT
        s.custname
        ,(s.partscost + s.laborcost) * (1+(s.taxrate/100)) AS "Total Service Cost"
        ,c.carmake
        ,c.carmodel
    FROM
        s11.servinv s, s11.car c
    WHERE
        (partscost + laborcost) = (
           SELECT DISTINCT
               MAX(partscost + laborcost)
           FROM
               s11.servinv
       ) and s.custname = c.custname;

/* ----->Output<-----
CUSTNAME             Total Service Cost CARMAKE    CARMODEL  
-------------------- ------------------ ---------- ----------
ALAA ATRI                         61020 MERCEDES   AMG63     
*/
 
 /*7 Select the car owner information of the most expensive car and Format the output*/
 SELECT
        'Name: ' ||c.custname||CHR(10)||
        'Address: ' ||c.custstreet||' - '||c.custcity||' - '||c.custprovince||' - '||c.custpostal||CHR(10)||
        'Car Maker: '||m.carmake||' - Model: '||m.carmodel as "Happiest Owner"
    FROM
        s11.saleinv p, s11.customer c, s11.car m
    WHERE
        p.carsaleprice = (
            SELECT DISTINCT
               MAX(p.carsaleprice)
           FROM
               s11.saleinv p
       ) and c.custname = p.custname AND m.carserial = p.carserial;

/* ----->Output<-----
Happiest Owner                                                                                                                          
----------------------------------------------------------------------------------------------------------------------------------------
Name: CORY SVENSSON
Address: 6240 Millers Grove - Mississauga - ON - L5N 3C8
Car Maker: MERCEDES - Model: FUNMOB

*/
 
 SPOOL off;
