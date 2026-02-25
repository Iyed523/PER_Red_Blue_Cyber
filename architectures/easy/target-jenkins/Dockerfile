FROM jenkins/jenkins:lts
ENV DEBIAN_FRONTEND=noninteractive

# 1. Passer en ROOT pour l'installation
USER root

# 2. Installation des outils de base
RUN apt-get update && apt-get install -y \
    curl gnupg apt-transport-https lsb-release \
    iputils-ping openssl vim \
    && rm -rf /var/lib/apt/lists/*

# 3. Installation de l'Agent Wazuh
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
RUN apt-get update && WAZUH_MANAGER="wazuh.manager" WAZUH_AGENT_VERSION="4.9.0-1" apt-get install -y wazuh-agent=4.9.0-1

# 4. Le Flag Final (Root Only)
RUN echo "FLAG{JENKINS_PASSWD_EXPLOIT_SUCCESS}" > /root/root_flag.txt
RUN chmod 600 /root/root_flag.txt

# 5. La Faille d'Escalade (Permissions abusives sur /etc/passwd)
# On rend le fichier modifiable par n'importe quel utilisateur (jenkins compris)
RUN chmod 666 /etc/passwd

# 6. Script de démarrage personnalisé
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
