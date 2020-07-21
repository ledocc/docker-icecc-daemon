

IMAGE_NAME=point/icecc-daemon
CONTAINER_NAME=icecc-daemon

VERBOSE_LEVEL:=1
SCHEDULER_HOST:=
NETNAME:=


build:
	docker build . -t ${IMAGE_NAME}

start:
	docker run -d \
	--net=host \
	--env ICECC_VERBOSE_LEVEL=${VERBOSE_LEVEL} \
	--env ICECC_SCHEDULER_HOST=${SCHEDULER_HOST} \
	--env ICECC_NETNAME=${NETNAME} \
	-v /var/log/icecc:/var/log/icecc \
	--name ${CONTAINER_NAME} \
	--restart=unless-stopped \
	${IMAGE_NAME}

stop:
	docker stop -t 0 ${CONTAINER_NAME}
	docker rm ${CONTAINER_NAME}
