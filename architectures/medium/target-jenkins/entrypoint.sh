#!/bin/bash

# On repasse temporairement en root pour configurer Wazuh
sudo -S bash <<EOF
if [ ! -z "$WAZUH_MANAGER_IP" ]; then
    sed -i "s/MANAGER_IP/$WAZUH_MANAGER_IP/g" /var/ossec/etc/ossec.conf
    sed -i "s/<address>wazuh.manager<\/address>/<address>$WAZUH_MANAGER_IP<\/address>/g" /var/ossec/etc/ossec.conf
fi
service wazuh-agent start
EOF

# Lancement officiel de Jenkins (script d'origine de l'image)
/usr/bin/tini -- /usr/local/bin/jenkins.sh
