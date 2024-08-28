#!/bin/sh

set -u

PUREFTPD_DIR="/etc/pure-ftpd"

sed -i "s/^#\sPassivePortRange.*/PassivePortRange $FTP_PASSIVE_PORTS/" "${PUREFTPD_DIR}/pure-ftpd.conf"
sed -i "s/^MaxClientsNumber.*/MaxClientsNumber $FTP_MAX_CLIENTS_NO/" "${PUREFTPD_DIR}/pure-ftpd.conf"
sed -i "s/^MaxClientsPerIP.*/MaxClientsPerIP $FTP_MAX_CLIENTS_PER_IP/" "${PUREFTPD_DIR}/pure-ftpd.conf"
sed -i "s/^MaxIdleTime.*/MaxIdleTime $FTP_MAX_IDLE_TIME/" "${PUREFTPD_DIR}/pure-ftpd.conf"
sed -i "s/^#\sPerUserLimits.*/PerUserLimits $PER_USER_LIMITS/" "${PUREFTPD_DIR}/pure-ftpd.conf"

sh ./set-permissions.sh

pure-ftpd "${PUREFTPD_DIR}/pure-ftpd.conf"
