what's the relationship between the Pods named NAME-server and the server from `gfsh start server`


start server \
--name=server1 \
--redis-port=11211 \
--J=-Dgemfireredis.regiontype=PARTITION_PERSISTENT


Starting a Geode Server in /data/server1...
.........
Server in /data/server1 on gemfire1-locator-0.gemfire1-locator.gemfire-cluster.svc.cluster.local[40404] as server1 is currently online.
Process ID: 11468
Uptime: 6 seconds
Geode Version: 1.13.1
Java Version: 11.0.9.1
Log File: /data/server1/server1.log
JVM Arguments: -Dgemfire.default.locators=10.200.35.135[10334] -Dgemfire.start-dev-rest-api=false -Dgemfire.use-cluster-configuration=true -Dgemfire.redis-port=11211 -Dgemfireredis.regiontype=PARTITION_PERSISTENT -Dgemfire.launcher.registerSignalHandlers=true -Djava.awt.headless=true -Dsun.rmi.dgc.server.gcInterval=9223372036854775806
Class-Path: /gemfire/lib/geode-core-1.13.1.jar:/gemfire/lib/geode-dependencies.jar
