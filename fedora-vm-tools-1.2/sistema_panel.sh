#!/bin/bash

clear
echo "🖥️  PANEL DE ESTADO - FEDORA VM"
echo "Fecha: $(date)"
echo "Usuario: $USER"
echo "Hostname: $(hostname)"
echo "--------------------------------------------"

echo "🧠 USO DE CPU:"
top -bn1 | grep "Cpu(s)" | awk '{print "Uso: " $2 + $4 "%"}'

echo -e "\n💾 USO DE MEMORIA:"
free -h

echo -e "\n📦 ESPACIO EN DISCO:"
df -h /

echo -e "\n⚠️ SERVICIOS FALLANDO:"
systemctl --failed --no-pager

echo -e "\n🌐 CONEXIÓN DE RED:"
ip -brief address | grep -v lo

echo -e "\n🌡️ TEMPERATURA DEL SISTEMA:"
sensors 2>/dev/null || echo "No disponible"

echo "--------------------------------------------"
