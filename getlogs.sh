#!/bin/bash

if [ -z "$1" ]; then
    echo
    echo " Script to grab karaf logs from cluster nodes (one file per node)"
    echo " Usage: $0 <node1> [<node2> [<node3> ... <nodeN>]]"
    echo
    echo "  node      - (mandatory) SSH alias of cluster node"
#    echo "  -h <home> - (optional, default=/home/odl) home folder on cluster nodes, where build is deployed"
    echo
    exit 1
fi

#logFolder=log$(date +%N)
logFolder=log-$(date +%Y%m%d-%H%M%S)
mkdir ${logFolder}

for i in $@ ; do
  echo $i
  ssh $i 'cd /home/odl/deploy/current/odl/data/log; cat $(ls -1rt karaf.log*)' > ${logFolder}/$i.log
done

