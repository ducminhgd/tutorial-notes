# Cassandra

1. Default *data center* of Cassandra is `datacenter1`.
2. Use `nodetool status` to check status of node and *data center name* is able to be gotten from the result.
3. Use `cqlsh` to connect to Cassandra.
4. Create keyspace after connect to Cassandra `CREATE KEYSPACE test_keyspace WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 1};`
