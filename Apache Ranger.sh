*********************************************
            Apache Ranger
*********************************************

- Login to Hue with Hive user
- Create a database zomatodb in hue
- Put dataset in /user/hive directory
- Create customer, order and restaurant table in zomatodb
- Create a user for Customer_support, Delivery_boy & Sales_team 

-----*** Setting policies in Ranger ***-----

## add users in ranger as same name used in hue
>> settings > users/groups/roles

--> Create policy for Customer support

AddNewPolicy
Policyname - customer-support
Database - zomatodb
Table - *
Columns - *
User - support | permissions - all

--> Create policy for Sales

AddNewPolicy
Policyname - sales-policy
Database - zomatodb
Table - restaurants
Columns - *
User - sales | permissions - all

--> Create policy for Delivery

AddNewPolicy
Policyname - delivery-policy-customers
Database - zomatodb
Table - customer
Columns - name,email,mobile,address
User - delivery | permissions - all

AddNewPolicy
Policyname - delivery-policy-orders
Database - zomatodb
Table - order
Columns - *
User - delivery | permissions - all

--->>> Login through the users and verify