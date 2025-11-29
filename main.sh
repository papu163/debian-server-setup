#!/usr/bin/env bash
# Este programa esta hecho para hacer un setup rapido
# de un servidor en debian, no me hago responsable
# por posibles errores en el programa que causen 
# que el sistema pueda ser inestable o directamente
# romperse
echo "Asegurate de poner valores validos, de lo contrario podras tener efectos no esperados"
read -p "Ingresa la direccion IP(privada) que quieres usar: " ipv4_privada
read -p "Ingresa tu netmask: " netmask
read -p "Ingresa tu gateway: " gateway
read -p "Ingresa la DNS que quieres usar: " dns 

#Setup de interfaz y DNS
echo "Obteniendo interfaz de red principal..."
INTERFACE=$(ip route show default | awk '{print $5}' | head -n1)
echo "La interfaz principal es: $INTERFACE"
echo "Creando copia de seguridad de /etc/network/interfaces en /home"
dia=$(date)
hostname=$(hostname -s)
archivo_cp="$hostname-$dia.txt"
cp /etc/network/interfaces "/home/$archivo_cp"
echo "Copia creada" 
echo "Aplicando cambios en /etc/network/interfaces"
echo "" > /etc/network/interfaces
echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "#loopback" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "#Primary interface" >> /etc/network/interfaces
echo "allow-hotplug $INTERFACE" >> /etc/network/interfaces
echo "iface $INTERFACE inet static" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "address $ipv4_privada" >> /etc/network/interfaces
echo "netmask $netmask" >> /etc/network/interfaces
echo "gateway $gateway" >> /etc/network/interfaces
echo "dns-nameservers $dns" >> /etc/network/interfaces
echo "#ipv6" >> /etc/network/interfaces
echo "iface $INTERFACE inet6 auto" >> /etc/network/interfaces
systemctl restart networking.service
#----Final----
#Preparacion
echo -e "\e[32mInstalando paquetes\e[0m: sudo, brightnessctl, ufw"
apt update && apt upgrade
apt install sudo brightnessctl ufw -y
echo "Preparando firewall(ufw)"
ufw allow ssh
ufw allow Samba
ufw allow http
ufw allow https
ufw enable
read -p "¿Desea usar ufw-docker(Bloquea a docker de sobrepasar el firewall)?[y/n]: " ufw_docker_create
yes1="y"
yes="Y"
if [ "$ufw_docker_create" == "$yes1" || "$ufw_docker_create" == "$yes" ]; then
    echo "Creando reglas de ufw-docker..."
    curl -O https://raw.githubusercontent.com/papu163/debian-server-setup/refs/heads/main/recursos/ufw-docker.txt
    cat ufw-docker.txt >> /etc/ufw/after.rules
else
    echo "Saltando configuracion de ufw-docker"
fi
echo "El script ha terminado"
echo "Aun hay configuracion pendiente, la puedes terminar siguiendo la guia del repositorio de github"
#----Final----
