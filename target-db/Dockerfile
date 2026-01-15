FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# 1. Installation MariaDB et Outils
RUN apt-get update && apt-get install -y \
    curl gnupg apt-transport-https lsb-release \
    mariadb-server iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# 2. Installation Wazuh Agent
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
RUN apt-get update && WAZUH_MANAGER="wazuh.manager" WAZUH_AGENT_VERSION="4.9.0-1" apt-get install -y wazuh-agent=4.9.0-1

# 3. Configuration Logs MariaDB
RUN mkdir -p /var/log/mysql && chown -R mysql:mysql /var/log/mysql
# On crée le fichier de conf qui force les logs
RUN echo "[mysqld]\nlog_error = /var/log/mysql/error.log\nlog_warnings = 2\nbind-address = 0.0.0.0" > /etc/mysql/mariadb.conf.d/99-custom.cnf

# 4. Config Wazuh pour lire le log
RUN sed -i '/<\/ossec_config>/i \
  <localfile>\n\
    <location>/var/log/mysql/error.log</location>\n\
    <log_format>syslog</log_format>\n\
  </localfile>' /var/ossec/etc/ossec.conf

# 5. Démarrage
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
