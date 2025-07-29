#!/bin/bash

echo "📦 Instalando herramientas de mantenimiento Fedora VM..."
INSTALL_DIR="$HOME/fedora_vm_tools"
mkdir -p "$INSTALL_DIR"

cp mantenimiento_fedora_vm.sh sistema_panel.sh "$INSTALL_DIR"
chmod +x "$INSTALL_DIR"/*.sh

# Solicitar credenciales de Telegram
read -p "🔑 TOKEN del bot de Telegram: " BOT_TOKEN
read -p "📩 chat_id (usuario o grupo): " CHAT_ID

# Sustituir en script de mantenimiento
sed -i "s/__BOT_TOKEN__/$BOT_TOKEN/" "$INSTALL_DIR/mantenimiento_fedora_vm.sh"
sed -i "s/__CHAT_ID__/$CHAT_ID/" "$INSTALL_DIR/mantenimiento_fedora_vm.sh"

# Agregar a crontab
CRON_LINE="30 3 * * 1 $INSTALL_DIR/mantenimiento_fedora_vm.sh >> $INSTALL_DIR/mantenimiento.log 2>&1"
(crontab -l 2>/dev/null | grep -v "$INSTALL_DIR/mantenimiento_fedora_vm.sh"; echo "$CRON_LINE") | crontab -

echo "✅ Instalación completa."
echo "🛠  Script de mantenimiento: $INSTALL_DIR/mantenimiento_fedora_vm.sh"
echo "📊 Panel de estado: $INSTALL_DIR/sistema_panel.sh"
echo "⏰ Ejecutándose cada lunes a las 3:30 a. m."
