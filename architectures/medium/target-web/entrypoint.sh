#!/bin/bash

# Configuration dynamique de l'IP Wazuh (via docker-compose)
if [ ! -z "$WAZUH_MANAGER_IP" ]; then
    sed -i "s/MANAGER_IP/$WAZUH_MANAGER_IP/g" /var/ossec/etc/ossec.conf
    sed -i "s/<address>wazuh.manager<\/address>/<address>$WAZUH_MANAGER_IP<\/address>/g" /var/ossec/etc/ossec.conf
fi

# Démarrage de l'agent Wazuh
service wazuh-agent start

# Démarrage d'Apache en premier plan
apache2-foreground
