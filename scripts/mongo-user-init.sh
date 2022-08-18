#!/usr/bin/env bash

CONTAINER_ID=$(docker ps -qf name=graylog_observability-mongodb.1)
PASSWORD=$(docker exec -it "$CONTAINER_ID" bash -c "cat /run/secrets/mongodb_root_password")

MONGO_ADMIN_CMD='admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "admin",
    pwd: "password",
    roles: [ { role: "readWrite", db: "graylog" }, { role: "dbAdmin", db: "graylog" } ]
  }
)'

docker exec -it \
  "$CONTAINER_ID" \
  bash -c "echo '${MONGO_ADMIN_CMD}' | mongo -u root -p $PASSWORD"
