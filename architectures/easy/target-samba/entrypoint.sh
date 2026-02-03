#!/bin/bash

# 1. Démarrer l'agent Wazuh (La surveillance)
echo "--> Démarrage de Wazuh Agent..."
service wazuh-agent start
service rsyslog start
# 2. Démarrer Samba (Le service vulnérable)
echo "--> Démarrage de Samba..."
service nmbd start
service smbd start
service ssh start

# 3. Boucle infinie pour garder le conteneur vivant
# On affiche les logs de Wazuh en continu, c'est pratique pour le debug
echo "--> Conteneur prêt. Surveillance des logs..."
tail -f /var/ossec/logs/ossec.log
