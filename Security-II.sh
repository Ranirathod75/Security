*********************************************
            Security II
*********************************************


----*** User Onboarding  ***----

# make sure kerberos is enabled on cluster
# connect to worker node
# 1] adding a POSIX account for an user

$ sudo useradd userb

#connect to CM host
# 2] adding principal for an user

$ sudo kadmin.local

$ addprinc userb

#connect to worker node
# 3] creating the userspace/home directory for an user

$ su hdfs
$ cd
$ kinit -p hdfs
$ hdfs dfs -mkdir /user/userb

# 4] chnaging ownership of an userspace 
$ hdfs dfs -ls /user
$ hdfs dfs -chown userb:userb /user/userb

# 5] assigning appropriate permission to the userspace
$ hdfs dfs -chmod 600 /user/userb


----*** Authorization  ***----

## Checking if ACL's are enabled in hdfs
-> Goto CM
-> HDFS -> Configurations -> search - acl

## On terminal
## create user and group 
$ hdfs dfs -mkdir -p /data/userc
$ hdfs dfs -chown userc:dev /data/userc
$ hdfs dfs -ls /data

## check ACL is enabled or not 
$ hdfs dfs -getfacl /data/userc

## set ACL
$ hdfs dfs -setfacl -m user:<username>:rwx /file/dir
                      group:<groupname>:rwx

                      or

$ hdfs dfs -setfacl [-R] [-b|-k -m|-x <acl_spec> <path>]|[--set <acl_spec> <path>]


<!-- COMMAND OPTIONS
<path>: Path to the file or directory for which ACLs should be set.
-R: Use this option to recursively list ACLs for all files and directories.
-b: Revoke all permissions except the base ACLs for user, groups and others.
-k: Remove the default ACL.
-m: Add new permissions to the ACL with this option. Does not affect existing permissions.
-x: Remove only the ACL specified.
<acl_spec>: Comma-separated list of ACL permissions.
--set: Use this option to completely replace the existing ACL for the path specified.
 Previous ACL entries will no longer apply.
-->

$ hdfs dfs -setfacl -m user:usera:r-x /data/userc
$ hdfs dfs -setfacl -m group:testers:rwx /data/userc
$ hdfs dfs -getfacl /data/userc
  
$ hdfs dfs -chmod 750 /data/userc
$ hdfs dfs -getfacl /data/userc

$ hdfs dfs -setfacl -b /data/userc
$ hdfs dfs -getfacl /data/userc


## Enabling sticky bits
## write = create, edit/modify, delete
## write(delete) = user/owner

$ hdfs dfs -chmod +t /data
$ hdfs dfs -ls / | grep data





