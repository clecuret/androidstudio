#!/bin/bash
set -e

if [ "$1" = 'androidstudio' ]; then
	uid=${UID:-1000}
	gid=${GID:-1000}
  lang=${LANG:-fr-FR}
	# create user group
	if ! getent group developer >/dev/null; then
		groupadd -f -g ${gid} developer
	fi

	# create user with uid and gid matching that of the host user
	if ! getent passwd developer >/dev/null; then
    chown ${uid}:${gid} -R /home/developer
		adduser --uid ${uid} --gid ${gid} --disabled-login --gecos 'Developer' developer
		echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    if  [ -e "/home/developer/.android/Sdk/platform-tools/adb" ]; then
			/home/developer/.android/Sdk/platform-tools/adb start-server
	  fi
	fi

	exec su developer -c "/opt/android-studio/bin/studio.sh"
fi

exec "$@"
