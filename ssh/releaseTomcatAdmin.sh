#!/bin/sh
# This is the shell script to release for something.
APP_NAME=tomcat
TOMCAT_PATH="/etc/init.d/"
APP_PATH="/usr/local/tomcat/webapps/admin"
WAR_PATH="/home/joonk/abilists/deploy"
WAR_FILE="ROOT.war"
USER_ID=joonk


echo ${APP_PATH}

case "$1" in
start)

	# Check the process count
	APP_CNT=`/bin/ps -ef | /bin/grep "tomcat" | /bin/grep -v "grep\|init.d" -c`
	if [ ${APP_CNT} -gt 0 ]; then
	        echo "Tomcat is already runing..."
	        exit 1
	fi

		# Build with gradle
		cd ~/git/abilists_admin
		gradle deployWar
		echo "Finished the builds."

        if [ -d "${APP_PATH}" ]; then
			echo "If the path exists."
			/bin/rm -rf ${APP_PATH}
        fi
		printf "%-50s" "Starting $NAME..."
		${TOMCAT_PATH}${APP_NAME} start
		RETVAL=$?
		if [ $RETVAL -eq 0 ]; then
			echo "successful start"
		else
			echo "failure starting"
			exit 1
		fi
;;

stop)
        printf "%-50s" "Starting $NAME..."

        ${TOMCAT_PATH}${APP_NAME} stop
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                echo "successful stop"
        else
                echo "failure stopping"
        fi
;;

*)
	echo "Usage: $0 {start|stop}"
	exit 1
esac