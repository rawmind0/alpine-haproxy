#!/usr/bin/env bash

HAPROXY_HOME=/opt/haproxy

case "$1" in
        "start")
            haproxy -f ${HAPROXY_HOME}/etc/haproxy.cfg -p ${HAPROXY_HOME}/haproxy.pid -sf $(cat ${HAPROXY_HOME}/haproxy.pid)
        ;;
        "restart")
            haproxy -f ${HAPROXY_HOME}/etc/haproxy.cfg -p ${HAPROXY_HOME}/haproxy.pid -sf $(cat ${HAPROXY_HOME}/haproxy.pid)
        ;;
        "stop")
            kill -15 $(cat ${HAPROXY_HOME}/haproxy.pid)
        ;;
        *) echo "Usage: $0 restart|start|stop"
        ;;

esac
