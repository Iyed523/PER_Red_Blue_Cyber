🛡️ Labo Cyber : Architecture "Defense in Depth" & Détection Wazuh
Ce projet déploie une infrastructure d'entraînement au hacking éthique entièrement conteneurisée. Il simule un réseau d'entreprise segmenté avec une DMZ, un Pivot, et un réseau interne caché, le tout surveillé par un SIEM Wazuh.

🏗️ Architecture
L'infrastructure est divisée en 3 zones pour simuler une défense en profondeur :

Zone Publique (DMZ) : Contient l'attaquant (Kali) et le serveur exposé (Samba).

Zone Privée (Interne) : Contient les cibles critiques (MariaDB, Tomcat). Ce réseau est invisible depuis Kali.

Réseau de Gestion : Permet à Wazuh de collecter les logs de toutes les machines via un canal sécurisé.


🚀 Installation & Démarrage
Pré-requis
Docker & Docker Compose installés.

4 Go de RAM recommandés (Wazuh est gourmand).

Lancement

# 1. Cloner le repo
git clone <VOTRE_URL_GITHUB>
cd wazuh-docker/single-node

# 2. Lancer l'infrastructure
sudo docker compose up -d --build
Note : Attendez environ 2-3 minutes que le serveur Wazuh s'initialise complètement.

🎮 Scénarios d'Exercice
🔴 Rôle Red Team (L'Attaquant)
L'objectif est de compromettre le serveur Samba, puis de l'utiliser comme Pivot pour attaquer la base de données cachée.

1. Accès à la machine d'attaque :


sudo docker exec -it kali_attacker /bin/bash
2. Attaque 1 : Brute Force sur la DMZ (Samba) Le serveur Samba refuse les invités. Tentez de forcer l'entrée pour générer du bruit :


for i in {1..10}; do smbclient //target-samba/public -U hacker%Fail$i -c "ls"; done
3. Attaque 2 : Mouvement Latéral (Pivot vers la DB) Depuis Kali, on ne voit pas la DB. Il faut passer par Samba. Connectez-vous au conteneur Samba (simulant une compromission) :


# Dans un autre terminal
sudo docker exec -it target_samba /bin/bash
Lancez l'attaque vers la cible cachée :

Bash

mysql -h target-db -u root -pMauvaisPassword
🔵 Rôle Blue Team (Le Défenseur)
L'objectif est de détecter ces intrusions en temps réel grâce aux règles personnalisées.

1. Accès au SIEM :

URL : https://127.0.0.1 (Accepter le risque SSL)

User : admin

Password : SecretPassword

2. Visualiser les Alertes : Allez dans Modules > Threat Hunting.

3. Alertes à rechercher : Nous avons créé des règles spécifiques pour ce scénario :

Règle ID 100002 : Samba: Tentative d'intrusion détectée (Access Denied)

Règle ID 100003 : MariaDB: Tentative d'intrusion via Pivot détectée

Si vous voyez ces alertes, la surveillance de la chaîne complète (DMZ + Interne) est validée.
