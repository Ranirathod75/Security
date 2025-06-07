*********************************************
         Kerberos Installation CDP
*********************************************

## add ranger service while creating a cluster for authorization

## ranger is a master service so make sure to start it on master node

## Install kerberos KDC and Admin server

## On Cm host install kdc and admin server


>> can bypass the basic security mechanism of hdfs (dfs.permission)

$ export HADDOP_USER_NAME = hdfs

>> connect to CM host

$ sudo apt-get install -y rng-tools

$ sudo apt install krb5-kdc krb5-admin-server

##initialize realm and setup kdc password
$ sudo krb5_newrealm

## Check the krb5.conf
$ nano /etc/krb5.conf

## Check kdc.conf for kdc configurations
$ sudo nano /usr/share/doc/krb5-kdc/examples/kdc.conf
Uncomment - supported enryption type

$ sudo /etc/init.d/krb5-admin-server restart

##connecting to admin server
$ sudo kadmin.local

## creating a principal
## $ addprinc <principal_name>

## create admin principal
$ addprinc cm/admin (here name could be anything)
$ exit

$ sudo nano /etc/krb5kdc/kadm5.acl
cm/admin@HADOOP.COM        *

$ sudo /etc/init.d/krb5-admin-server restart


## Install Kerberos Clients
## Install this on all remaining hosts
$ sudo apt-get install krb5-user -y

## initialize TGT 
$ kinit -p <principal_name>

## check TGT
$ klist

## destroy TGT 
$ kdestroy

>>go under cdp >> administration >> security >> enable kerberos >> continue if all steps are correct

>> under Enter KDC Information >> give Kerberos Security Realm (if not given)
>> give KDC Server Host >> give KDC Admin Server Host
>> give Maximum Renewable Life for Principals = 7
>> select Kerberos Encryption Types = aes256-cts (important configuration)
>> Enter account credentials for admin principal >> continue 

## Create a principal for hdfs superuser
>>go under KDC
$ sudo kadmin.local
addprinc hdfs

>> go to worker node
$ su hdfs
$ kinit -p hdfs
$ klist
$ hdfs dfs -ls /  (this should run)


## Creating service principal            (Don't need to create in cloudera)
$ addprinc <service_name>/<service_dns>@realm  

## Creating and using keytab files
--* Create principal and its keytab *--

$ sudo kadmin.local
addprinc user2
xst -kt /tmp/user2.keytab user2@HADOOP.COM

--* Send keytab files to user *--
$ sudo chmod a+r /tmp/user2.keytab
$ scp -i key.pem /tmp/user2.keytab ubuntu@ip-172-31-87-98.ec2.internal:~

--* Authenticate using keytab *--
$ chmod 600 user2.keytab
$ kinit -kt user2.keytab user2
$ klist



## Kerberos Commands
-> Adding principal
addprinc prinname

-> Deleting Principal
delprinc princname

-> Listing all principals
listprincs

-> Getting information about a particular principal
getprinc princname

-> Change password for particular principal
cpw princname



