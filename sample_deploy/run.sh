#!/bin/bash

LOCUST="/usr/local/bin/locust"
LOCUST_OPTS="-f $LOCUST_TASK --host=$TARGET_HOST"
LOCUST_MODE=${LOCUST_MODE:-standalone}

if [[ "$LOCUST_MODE" = "master" ]]; then
    LOCUST_OPTS="$LOCUST_OPTS --master"
elif [[ "$LOCUST_MODE" = "worker" ]]; then
    LOCUST_OPTS="$LOCUST_OPTS --slave --master-host=$LOCUST_MASTER"
fi

echo "$LOCUST $LOCUST_OPTS"

$LOCUST $LOCUST_OPTS
