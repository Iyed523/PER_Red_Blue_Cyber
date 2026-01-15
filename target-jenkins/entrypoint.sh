#!/bin/bash

# 1. Démarrer l'agent Wazuh en arrière-plan
service wazuh-agent start

# 2. Démarrer Jenkins (commande officielle de l'image)
# On utilise le script de démarrage standard de Jenkins
/usr/local/bin/jenkins.sh
