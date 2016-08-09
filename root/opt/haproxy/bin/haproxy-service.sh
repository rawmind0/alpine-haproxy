#!/usr/bin/env bash

function log {
        echo `date` $ME - $@
}

function serviceStart {
    log "[ Starting ${SERVICE_NAME}... ]"
    haproxy -f ${SERVICE_CONF} -p ${SERVICE_HOME}/haproxy.pid -sf $(cat ${HAPROXY_HOME}/haproxy.pid)
}

function serviceStop {
    log "[ Stoping ${SERVICE_NAME}... ]"
    kill -15 $(cat ${SERVICE_HOME}/haproxy.pid)
}

function serviceRestart {
    log "[ Restarting ${SERVICE_NAME}... ]"
    serviceStop
    serviceStart
    /opt/monit/bin/monit reload
}

case "$1" in
        "start")
            serviceStart &>> /proc/1/fd/1
        ;;
        "stop")
            serviceStop &>> /proc/1/fd/1
        ;;
        "restart")
            serviceRestart &>> /proc/1/fd/1
        ;;
        *) echo "Usage: $0 restart|start|stop"
        ;;

esac

