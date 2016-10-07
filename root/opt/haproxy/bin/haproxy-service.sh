#!/usr/bin/env bash

function log {
    echo `date` $ME - $@
}

function compileCfg {
    log "[ Compiling *.cfg files from ${SERVICE_HOME}/etc/conf.d... ]"
    cat ${SERVICE_HOME}/etc/conf.d/*.cfg > ${SERVICE_CONF}
    log "[ Checking if new config is valid... ]"
    haproxy -c -f ${SERVICE_CONF}
    if [ $? -eq 0 ]; then
      log "[ Config OK. ]"
    else
      log "[ FATAL: There are errors in new configuration, please fix them and try again. ]"
      exit 1
    fi
}

function serviceStart {
    compileCfg
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

