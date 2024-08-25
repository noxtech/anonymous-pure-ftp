#!/bin/sh

sed -i "s/^#\sPassivePortRange.*/PassivePortRange $FTP_PASSIVE_PORTS/" /etc/pure-ftpd.conf
sed -i "s/^MaxClientsNumber.*/MaxClientsNumber $FTP_MAX_CLIENTS_NO/" /etc/pure-ftpd.conf
sed -i "s/^MaxClientsPerIP.*/MaxClientsPerIP $FTP_MAX_CLIENTS_PER_IP/" /etc/pure-ftpd.conf
sed -i "s/^MaxIdleTime.*/MaxIdleTime $FTP_MAX_IDLE_TIME/" /etc/pure-ftpd.conf

pure-ftpd /etc/pure-ftpd.conf
