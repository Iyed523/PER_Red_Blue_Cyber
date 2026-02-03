#!/bin/bash

# 1. Démarrage de l'agent Wazuh
echo "--> Démarrage de Wazuh Agent..."
service wazuh-agent start

# 2. Démarrage de SSH (C'est ça qu'il manquait !)
echo "--> Démarrage du serveur SSH..."
service ssh start

# 3. Démarrage du serveur FTP (vsftpd)
echo "--> Démarrage du serveur FTP..."
service vsftpd start

# 4. Maintien du conteneur en vie (et affichage des logs pour le debug)
echo "--> Conteneur prêt. Logs :"
tail -f /var/log/vsftpd.log
