 
 /* View Creation */
 
 CREATE OR REPLACE VIEW service_customer_info AS
        SELECT
            c.custname
            ,c.custcity
            ,c1.carmake
            ,c1.carmodel
            ,s.servinvno
            ,s.servdate
            ,( s.partscost + s.laborcost ) AS "TOTAL_COST"
       FROM
           s11.customer c
           LEFT JOIN s11.car c1 ON c.custname = c1.custname
           LEFT JOIN s11.servinv s ON c.custname = s.custname;

View SERVICE_CUSTOMER_INFO created.

 
 /* #1 */
 
 SELECT
        upper(custcity) AS "CITY"
        ,COUNT(custname) AS "#_OF_CUSTOMERS"
    FROM
        service_customer_info
    WHERE
        upper(custcity) 
    IN (
            'OAKVILLE'
           ,'BRAMPTON'
           ,'TORONTO'
           ,'MISSISSAUGA'
       )
   GROUP BY
       upper(custcity)
   ORDER BY
       COUNT(custname) DESC;
/*  ---->Output<----
CITY                 #_OF_CUSTOMERS
-------------------- --------------
MISSISSAUGA                     443
OAKVILLE                        337
BRAMPTON                        199
TORONTO                         125
*/
 
 /* #2 */
 
 SELECT
        custname
        ,SUM(total_cost) AS "TOTAL_SPENT"
    FROM
        service_customer_info
    WHERE
        upper(custname) = 'JOHN DOE'
    GROUP BY
        custname;
/* ---->Output<----
CUSTNAME             TOTAL_SPENT
-------------------- -----------
JOHN DOE                    1365

*/
 /* #8 */
 
 SELECT
        carmake
        ,ROUND(AVG(total_cost),2) AS "AVERAGE_SPENT"
    FROM
        service_customer_info
    WHERE
        upper(carmake) = 'JAGUAR'
    GROUP BY
        carmake;
/* ---->Output<----
CARMAKE    AVERAGE_SPENT
---------- -------------
JAGUAR            700.25
*/
 
 SPOOL OFF
