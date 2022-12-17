# MySQL Group Replication with Docker

MySQL Group Replication (GR) is a MySQL Server plugin that enables you to create elastic, highly-available, fault-tolerant replication topologies.In this repository we've created 3 mysql server instance among them one is master and other two are slave. You can easily install this in your local environment to test the group replication with some easy steps.


First pull the repository and run the below command to complete the installation:
!! Be sure that you copy the `.env.example` file to`.env` and change based on your local configuration !!
```
chmod +x ./install.sh && ./install.sh
```

By now, you should see:
```console
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+----------------------------+
| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION | MEMBER_COMMUNICATION_STACK |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+----------------------------+
| group_replication_applier | ccf3f30a-7e30-11ed-9c9e-0242ac1c0002 | server2     |        3306 | ONLINE       | SECONDARY   | 8.0.31         | XCom                       |
| group_replication_applier | ccf42bb4-7e30-11ed-91bd-0242ac1c0004 | server3     |        3306 | RECOVERING   | SECONDARY   | 8.0.31         | XCom                       |
| group_replication_applier | ccf4f6c5-7e30-11ed-8359-0242ac1c0003 | server1     |        3306 | ONLINE       | PRIMARY     | 8.0.31         | XCom                       |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+----------------------------+
```

Congratulations :). You have done it. We also have a helpful bash script for your daily use.

```
# To down and up all container
./mysql.sh boot

# To start all container
./mysql.sh start

# To restart all container
./mysql.sh restart

# To stop all container
./mysql.sh stop

# To SSH into a server and open mysql shell
./mysql.sh node1
```