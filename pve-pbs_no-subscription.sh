#!/bin/bash

# Fonction pour PVE
configure_pve() {
    echo "Configuration pour Proxmox VE (PVE)..."
    
    # Modifier /etc/apt/sources.list
    echo "Modification de /etc/apt/sources.list..."
    cat <<EOL > /etc/apt/sources.list
deb http://ftp.debian.org/debian bookworm main contrib
deb http://ftp.debian.org/debian bookworm-updates main contrib

# Proxmox VE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription

# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib
EOL

    # Modifier /etc/apt/sources.list.d/ceph.list
    echo "Modification de /etc/apt/sources.list.d/ceph.list..."
    echo "deb http://download.proxmox.com/debian/ceph-reef bookworm no-subscription" > /etc/apt/sources.list.d/ceph.list

    # Supprimer pve-enterprise.list
    echo "Suppression de /etc/apt/sources.list.d/pve-enterprise.list..."
    rm -f /etc/apt/sources.list.d/pve-enterprise.list

    echo "Configuration pour PVE terminée."
}

# Fonction pour PBS
configure_pbs() {
    echo "Configuration pour Proxmox Backup Server (PBS)..."
    
    # Modifier /etc/apt/sources.list
    echo "Modification de /etc/apt/sources.list..."
    cat <<EOL > /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main contrib
deb http://deb.debian.org/debian bookworm-updates main contrib

# Proxmox Backup Server pbs-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pbs bookworm pbs-no-subscription

# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib
EOL

    # Supprimer pbs-enterprise.list
    echo "Suppression de /etc/apt/sources.list.d/pbs-enterprise.list..."
    rm -f /etc/apt/sources.list.d/pbs-enterprise.list

    echo "Configuration pour PBS terminée."
}

# Menu pour choisir PVE ou PBS
echo "Voulez-vous configurer Proxmox VE (PVE) ou Proxmox Backup Server (PBS) ?"
echo "1) PVE"
echo "2) PBS"
read -rp "Entrez votre choix (1 ou 2) : " choice

case $choice in
    1)
        configure_pve
        ;;
    2)
        configure_pbs
        ;;
    *)
        echo "Choix invalide. Veuillez relancer le script et choisir 1 ou 2."
        ;;
esac
