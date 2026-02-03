#!/bin/bash

# 1. Démarrage de Wazuh (Doit être fait en ROOT)
echo "🔴 Démarrage de l'agent Wazuh..."
service wazuh-agent start

# 2. Lancement de Jenkins (On passe la main à l'utilisateur 'jenkins')
# 'su jenkins -c' exécute la commande en tant que cet utilisateur
echo "🟢 Lancement de Jenkins (User: jenkins)..."
su jenkins -c "/usr/bin/tini -- /usr/local/bin/jenkins.sh"
