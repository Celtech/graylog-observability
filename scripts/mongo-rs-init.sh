#!/usr/bin/env bash
SERVERS=3

echo "Building replica set member list"
for (( c=1; c<=$SERVERS; c++ )); do
  MEMBERS="$MEMBERS {_id: $c, host: \"observability-mongodb-$c:27017\"}"

  if [ "$c" != $SERVERS ]; then
       MEMBERS="$MEMBERS,"
  fi
done

RSCONFIG="rs.initiate({_id: \"ObservabilitySet\", version: 1, members: [$MEMBERS]})"
echo $RSCONFIG

docker exec -it \
  $(docker ps -qf "label=com.docker.swarm.service.name=graylog_observability-mongodb" -f "health=healthy" -n 1) \
  bash -c "mongo --host observability-mongodb-1:27017 --eval $RSCONFIG"
