FROM php:7.4-apache

# 1. Installation des outils nécessaires
# gcc est requis pour que l'attaquant puisse compiler son exploit C
RUN apt-get update && apt-get install -y \
    sudo \
    gcc \
    netcat-traditional \
    wazuh-agent \
    && rm -rf /var/lib/apt/lists/*

# 2. Configuration de la faille LD_PRELOAD (Escalade Root)
# On autorise l'utilisateur www-data à lancer /usr/bin/gzip en sudo sans mot de passe
# ET on garde la variable d'environnement LD_PRELOAD
RUN echo "www-data ALL=(root) NOPASSWD: /usr/bin/gzip" >> /etc/sudoers
RUN echo 'Defaults env_keep += "LD_PRELOAD"' >> /etc/sudoers

# 3. Copie du site web vulnérable
COPY src/ /var/www/html/
# On crée le dossier uploads et on donne les droits à www-data
RUN mkdir /var/www/html/uploads && \
    chown -R www-data:www-data /var/www/html && \
    chmod 777 /var/www/html/uploads

# 4. Configuration de l'agent Wazuh (IP temporaire, sera écrasée par le docker-compose)
RUN echo "WAZUH_MANAGER_IP=172.17.0.1" > /IP_WAZUH

# 5. Script de démarrage
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
