FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# 1. Installation des paquets
# ### AJOUT ### : On ajoute 'openssh-server' pour pouvoir se connecter après le brute force
RUN apt-get update && apt-get install -y \
    curl gnupg apt-transport-https lsb-release \
    samba iputils-ping rsyslog \
    openssh-server nano \
    && rm -rf /var/lib/apt/lists/*

# 2. Installation Agent Wazuh (Inchangé)
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
RUN apt-get update && WAZUH_MANAGER="wazuh.manager" WAZUH_AGENT_VERSION="4.9.0-1" apt-get install -y wazuh-agent=4.9.0-1

# 3. Configuration SSH ### AJOUT ###
# On crée le dossier nécessaire pour SSH
RUN mkdir /var/run/sshd
# On s'assure que la connexion par mot de passe est autorisée
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 4. Configuration de l'Attaque
# A. Création de l'utilisateur cible 'sambauser'
RUN useradd -m -s /bin/bash sambauser

# ### AJOUT CRUCIAL ### : On définit le mot de passe SYSTEME (pour SSH)
# Avant tu ne définissais que le mot de passe Samba. Ici on met le même pour Linux.
RUN echo "sambauser:sambapass123" | chpasswd

# B. Définition du mot de passe Samba (Pour le partage de fichiers)
RUN (echo "sambapass123"; echo "sambapass123") | smbpasswd -a -s sambauser

# C. Création du dossier PUBLIC
RUN mkdir -p /srv/public
RUN chmod 777 /srv/public
RUN echo "Note pour l'admin : Le compte 'sambauser' est prêt. Login SSH activé." > /srv/public/note_service.txt

# D. Création du dossier PRIVÉ
RUN mkdir -p /srv/private
RUN echo "FLAG{SAMBA_PWNED}" > /srv/private/flag.txt
RUN chown -R sambauser:sambauser /srv/private && chmod 700 /srv/private

# 5. Injection du fichier de conf Samba
COPY smb.conf /etc/samba/smb.conf

# 6. Config Wazuh (Logs Samba + SSH)
RUN sed -i '/<\/ossec_config>/i \
  <localfile>\n\
    <location>/var/log/samba/log.smbd</location>\n\
    <log_format>syslog</log_format>\n\
  </localfile>\n\
  <localfile>\n\
    <location>/var/log/auth.log</location>\n\
    <log_format>syslog</log_format>\n\
  </localfile>' /var/ossec/etc/ossec.conf

# 7. Démarrage
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
# On expose SSH (22) et Samba (139/445)
EXPOSE 22 139 445
ENTRYPOINT ["/entrypoint.sh"]
