FROM ubuntu:20.04

# Éviter les questions interactives lors de l'install
ENV DEBIAN_FRONTEND=noninteractive

# 1. Installation des paquets (Samba, Python, Outils réseau)
RUN apt-get update && apt-get install -y \
    samba \
    python3 \
    libcap2-bin \
    netcat \
    iproute2 \
    curl \
    gnupg \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# 2. Installation de l'agent Wazuh
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list && \
    apt-get update && apt-get install -y wazuh-agent

# 3. Création de l'utilisateur légitime (que l'étudiant va voler)
# Mot de passe : "S3cur3P@ssw0rd!" (C'est ce qu'il devra trouver)
RUN useradd -m -s /bin/bash user_samba && \
    echo "user_samba:S3cur3P@ssw0rd!" | chpasswd

# 4. Mise en place de la faille "Misconfiguration" (Fuite de données)
RUN mkdir -p /srv/samba/backups
# On crée un script python qui contient le mot de passe en clair
RUN echo "db_password = 'S3cur3P@ssw0rd!'" > /srv/samba/backups/config.py
RUN chmod 644 /srv/samba/backups/config.py

# 5. Mise en place de la faille "Capabilities" (Escalade Root)
# On donne à Python le droit de changer d'UID (devenir Root)
RUN setcap cap_setuid+ep /usr/bin/python3.8


# LE FLAG FINAL (ROOT ONLY)
RUN echo "FLAG{MEDIUM_SAMBA_PYTHON_CAPS}" > /root/root_flag.txt
RUN chmod 600 /root/root_flag.txt


# 6. Configuration Samba et Wazuh
COPY smb.conf /etc/samba/smb.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


# Ports Samba
EXPOSE 139 445

ENTRYPOINT ["/entrypoint.sh"]
