# Graylog observability

This repository showcases a redundant, highly available, multi-node Graylog 
cluster. Following this demo will teach you to create three service replicas per 
service across three nodes for the following: 

- HAProxy
- Graylog 
- Elasticsearch
- Mongodb

This will allow you to maintain quorum and create a highly available logging 
cluster that can be updated and maintained with zero downtime. Beyond that we 
will explore the best practices for configuration, security, TLS termination and
more.

## System requirements

### CPU

- Minimum: 2 cores
- Recommended: 4 cores

### RAM

- Minimum: 4 Gb
- Recommended: 8 Gb

## Quick start (manual)

1. Git clone this repo
2. Init a swarm
3. Join other nodes to the swarm
4. Set up secrets
5. `docker stack deploy --prune -c docker-compose.yml graylog`

## Quick start (CI/CD)

TODO

### Gitlab

### Github
