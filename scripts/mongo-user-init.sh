#!/usr/bin/env bash

CONTAINER_ID=$(docker ps -qf "label=com.docker.swarm.service.name=graylog_observability-mongodb" -f "health=healthy" -n 1)
MONGO_ADMIN_CMD='admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "admin",
    pwd: "password",
    roles: [ { role: "root", db: "admin" } ]
  }
)'

docker exec -it \
  "$CONTAINER_ID" \
  bash -c "echo '${MONGO_ADMIN_CMD}' | mongo"
