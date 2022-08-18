# MongoDB common questions

## Should I put MongoDB behind the load balancer?

Most of the time the answer is no. MongoDB is set up in a replicated cluster for our deployment and as such is capable
of handling routing and concurrent requests. For the most part you would just end up introducing a small amount of
network latency.

[Read more about MongoDB replication](https://www.mongodb.com/docs/v4.4/replication/)

If you find you're having read write issues, a better solution is to add sharding to the MongoDB replication cluster 
rather than introducing a load balancer.

[Read more about converting your replication cluster to a sharded cluster](https://www.mongodb.com/docs/v4.4/tutorial/convert-replica-set-to-replicated-shard-cluster/)
