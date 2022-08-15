#!/usr/bin/env bash
SERVERS=3
REPLICA_SET_NAME=ObservabilitySet

echo "Building replica set member list"
for (( c=1; c<=$SERVERS; c++ )); do
  MEMBERS="$MEMBERS {_id: $c, host: \"observability-mongodb-$c:27017\"}"

  if [ "$c" != $SERVERS ]; then
       MEMBERS="$MEMBERS,"
  fi
done

echo "Creating Mongodb replica set $REPLICA_SET_NAME"

RSCONFIG="rs.initiate({_id: \"$REPLICA_SET_NAME\", version: 1, members: [$MEMBERS]})"
CONTAINER_ID=$(docker ps -qf name=graylog_observability-mongodb.1)
PASSWORD=$(docker exec -it "$CONTAINER_ID" bash -c "cat /run/secrets/mongodb_root_password")

docker exec -it \
  "$CONTAINER_ID" \
  bash -c "echo '${RSCONFIG}' | mongo -u root -p $PASSWORD"
