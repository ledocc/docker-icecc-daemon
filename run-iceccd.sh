#!/bin/sh

OPTS=""

if [ -n "${ICECC_VERBOSE_LEVEL}" ]
then
   OPTS=$(printf -- "-%.${ICECC_VERBOSE_LEVEL}s" vvv)
fi

if [ -n "${ICECC_NETNAME}" ]
then
   OPTS="${OPTS} -n ${ICECC_NETNAME}"
fi

if [ -n "${ICECC_SCHEDULER_HOST}" ]
then
   OPTS="${OPTS} -s ${ICECC_SCHEDULER_HOST}"
fi

if [ -n "${ICECC_MAX_JOBS}" ]
then
   OPTS="${OPTS} -m ${ICECC_MAX_JOBS}"
fi


LOG_DIR=/var/log/icecc
mkdir -p ${LOG_DIR}
chown icecc ${LOG_DIR}

iceccd ${OPTS} -l ${LOG_DIR}/iceccd.log -u icecc
