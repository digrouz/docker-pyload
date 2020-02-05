#!/usr/bin/env bash

. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

MYUSER="${APPUSER}"
MYGID="${APPGID}"
MYUID="${APPUID}"

AutoUpgrade
ConfigureUser
ConfigureSsmtp

if [ "${1}" == 'pyload' ]; then
  if [ -d /config ]; then
    chown -R "${MYUSER}":"${MYUSER}" /config
    chmod 0775 /config
  fi

  if [ -e /config/pyload.pid ]; then
    rm /config/pyload.pid
  fi

  for script in package_finished download_finished; do
    if [ ! -d /config/scripts/${script} ]; then
      mkdir -p /config/scripts/${script}
      chown -R "${MYUSER}":"${MYUSER}" /config/scripts/${script}
      chmod 0775 /config/scripts/${script}
    fi
  done
  if [ ! -f /config/scripts/package_finished/mail-notification.sh ]; then
    cp /usr/local/bin/pyload-package-finished-mail-notification.sh  /config/scripts/package_finished/mail-notification.sh
    chown -R "${MYUSER}":"${MYUSER}" /config/scripts/package_finished/mail-notification.sh
    chmod 0775 /config/scripts/package_finished/mail-notification.sh
  fi
  if [ ! -f /config/scripts/download_finished/mail-notification.sh ]; then
    cp /usr/local/bin/pyload-download-finished-mail-notification.sh  /config/scripts/download_finished/mail-notification.sh
    chown -R "${MYUSER}":"${MYUSER}" /config/scripts/download_finished/mail-notification.sh
    chmod 0775 /config/scripts/download_finished/mail-notification.sh
  fi

  RunDropletEntrypoint

  DockLog "Starting app: ${1}"
  exec su-exec "${MYUSER}" python /opt/pyload/pyLoadCore.py --configdir=/config
else
  DockLog "Starting command: ${1}"
  exec "$@"
fi
