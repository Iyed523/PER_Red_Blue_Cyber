#!/bin/bash

# Création des dossiers système (Vital pour MariaDB)
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
touch /var/log/mysql/error.log
chown -R mysql:mysql /var/log/mysql

# Démarrage des services
service wazuh-agent start
service mariadb start

# Config SQL (Après 5 secondes)
sleep 5
mariadb -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;" || true
mariadb -e "FLUSH PRIVILEGES;" || true

# Garder le conteneur vivant
tail -f /var/log/mysql/error.log
