#!/bin/bash
 
TYPE=$1
NAME=$2
STATE=$3
 
case $STATE in
    "MASTER") ipsec restart ECS-to-HOUSE
              exit 0
              ;;
    "BACKUP") ipsec stop ECS-to-HOUSE
              exit 0
              ;;
    "FAULT")  ipsec stop ECS-to-HOUSE
              exit 0
              ;;
    *)        echo "unknown state"
              exit 1
              ;;
esac