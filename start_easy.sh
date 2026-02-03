#!/bin/bash

# ============================================================
# SCRIPT DE LANCEMENT - ARCHITECTURE EASY
# ============================================================

echo "🔵 [1/3] Démarrage du Commissariat (Wazuh Blue Team)..."
cd ~/Bureau/PER/wazuh-docker/single-node
sudo docker-compose up -d
# On attend un peu que la base de données s'allume
echo "   ⏳ Attente de 30 secondes pour le démarrage de Wazuh..."
sleep 30

echo "🔴 [2/3] Démarrage de la Scène de Crime (Architecture Easy)..."
cd ~/Bureau/PER/architectures/easy
sudo docker-compose up -d

echo "🔄 [3/3] Réveil forcé des agents (Connexion au 172.17.0.1)..."
# On force le redémarrage de l'agent pour être sûr qu'il se connecte
sudo docker exec target_ftp_easy service wazuh-agent restart
sudo docker exec target_apache_easy service wazuh-agent restart
sudo docker exec target_samba_easy service wazuh-agent restart
sudo docker exec target_jenkins_easy service wazuh-agent restart


echo "============================================================"
echo "✅ LABO EASY PRÊT !"
echo "============================================================"
echo "📊 Dashboard Wazuh : https://127.0.0.1 (Login: admin / SecretPassword)"
echo ""
echo "🗡️  POUR ATTAQUER (Connexion SSH) :"
echo "   👉 Commande     : ssh root@127.0.0.1 -p 2222"
echo "   👉 Mot de passe : root"
echo "============================================================"
