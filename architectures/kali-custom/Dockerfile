FROM kalilinux/kali-rolling

# 1. Mise à jour et installation des outils de base + SSH
RUN apt-get update && apt-get install -y \
    openssh-server \
    iproute2 \
    net-tools \
    nano \
    nmap \
    iputils-ping \
    proxychains4 \
    ftp \
    smbclient \
    netcat-traditional \
    && rm -rf /var/lib/apt/lists/*

# 2. Configuration de SSH
RUN mkdir -p /var/run/sshd
# On autorise le login en root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 3. Définition du mot de passe (root / toor)
RUN echo 'root:root' | chpasswd

# 4. Ouverture du port 22
EXPOSE 22

# 5. Lancement de SSH au démarrage du conteneur
CMD ["/usr/sbin/sshd", "-D"]
