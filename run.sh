#!/bin/sh

### BEGIN INIT INFO
# Provides:          a shell script to start the consumers or replication in background
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Example initscript
# Description:       a shell script to start the consumers or replication in background
#                    args [1] = replication_service or consumer service [1 = replication , 2 = consumer]
#                    args [2] = config yaml file location

### END INIT INFO

# Author: Indika Maligaspe <indikamaligaspe@securmatic.com>
if [ "$1" -eq "1" ] ; then
   echo "Starting replication service"
   venv/bin/python2 replication_service/replicator/rabbitMQ_replicator.py $2  &
else
    echo "Starting consumer service"
    venv/bin/python2 replication_service/consumers/rabbitMQ_consumer.py $2  &
fi
