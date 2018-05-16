#!/bin/bash

date=`date '+%Y-%m-%d %H:%M:%S'`
echo "$date - Start mongo-connector..."

mongo=$(cat /data/config.json | python -c 'import json,sys;obj=json.load(sys.stdin);print(obj["mainAddress"])';)
mongoport="${MONGO_PORT:-27017}"

function _mongo() {
    mongo --quiet --host ${mongo} --port ${mongoport}  <<EOF
    $@
EOF
}

is_master_result="false"
expected_result="true"

while true;
do
  if [ "${is_master_result}" == "${expected_result}" ] ; then
    is_master_result=$(_mongo "rs.isMaster().ismaster")
    echo "Waiting for Mongod node to assume primary status..."
    sleep 3
  else
    echo "Mongod node is now primary"
    break;
  fi
done

sleep 1

exec mongo-connector -c /data/config.json $EXTRA_OPTS