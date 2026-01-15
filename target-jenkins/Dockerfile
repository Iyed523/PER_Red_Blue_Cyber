FROM jenkins/jenkins:lts
ENV DEBIAN_FRONTEND=noninteractive

# 1. Passer en ROOT pour pouvoir installer des paquets
USER root

# 2. Installation des outils de base
RUN apt-get update && apt-get install -y \
    curl gnupg apt-transport-https lsb-release \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# 3. Installation de l'Agent Wazuh
# (C'est la même méthode que pour tes autres machines)
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
RUN apt-get update && WAZUH_MANAGER="wazuh.manager" WAZUH_AGENT_VERSION="4.9.0-1" apt-get install -y wazuh-agent=4.9.0-1

# 4. Configuration de la faille (Pas besoin de fichier spécifique)
# Jenkins est vulnérable "par design" via sa console de script si on n'a pas de mot de passe.
# On s'assure juste que l'utilisateur a les droits.

# 5. Script de démarrage personnalisé
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# On remet l'utilisateur Jenkins si on voulait être réaliste, 
# MAIS pour faciliter ton attaque et l'escalade de privilèges, on reste en ROOT.
# USER jenkins  <-- On commente cette ligne pour rester Root.

ENTRYPOINT ["/entrypoint.sh"]
