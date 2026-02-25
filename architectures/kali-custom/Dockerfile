FROM kalilinux/kali-rolling

# Éviter les questions pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. Installation du serveur SSH et des outils de base pour le TP
RUN apt-get update && apt-get install -y \
    openssh-server \
    net-tools \
    iputils-ping \
    iproute2 \
    curl \
    wget \
    nano \
    vim \
    nmap \
    netcat-traditional \
    proxychains4 \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 2. Configuration SSH (Indispensable pour Docker)
RUN mkdir -p /var/run/sshd
# Autoriser le login Root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Correction d'un bug fréquent de PAM dans Docker qui déconnecte immédiatement
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# 3. Définition du mot de passe root (root:root)
RUN echo 'root:root' | chpasswd

# 4. On expose le port
EXPOSE 22

# 5. DÉMARRAGE AUTOMATIQUE
# On lance SSH et on empêche le conteneur de s'éteindre
CMD service ssh start && tail -f /dev/null
