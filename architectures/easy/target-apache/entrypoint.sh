#!/bin/bash
service wazuh-agent start
service apache2 start
service ssh start
service cron start
# On lance rsyslog pour avoir les logs auth.log immédiatement
apt-get install -y rsyslog && service rsyslog start
tail -f /var/log/apache2/access.log
