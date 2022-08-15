#!/usr/bin/env bash

CONTAINER_ID=$(docker ps -qf name=graylog_observability-mongodb.1)
MONGO_ADMIN_CMD='admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "admin",
    pwd: "password",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)'

docker exec -it \
  "$CONTAINER_ID" \
  bash -c "echo '${MONGO_ADMIN_CMD}' | mongo"
