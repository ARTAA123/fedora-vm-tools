#!/bin/bash

LOG_FILE="$HOME/fedora_vm_tools/mantenimiento.log"
BOT_TOKEN="8288967647:AAFY0G6ZR8_lGgT_JljmHDhxXT7D75UB7TE"
CHAT_ID="718371031"

{
  echo "==== 🛠️ Mantenimiento Fedora VM ===="
  echo "Fecha: $(date)"
  echo
  sudo dnf update -y
  sudo dnf autoremove -y
  sudo dnf clean all
  rm -rf ~/.cache/*
  echo
  echo "📦 Espacio utilizado en disco:"
  sudo du -h / --max-depth=1 2>/dev/null | sort -hr | head -n 10
  echo
  echo "⚙️ Servicios innecesarios activos:"
  systemctl list-units --type=service --state=running | grep -E 'bluetooth|cups|ModemManager' || echo "No detectados"
  echo
  echo "🚨 Últimos errores críticos:"
  journalctl -p 3 -xb | tail -n 10 || echo "Sin errores críticos."
} > "$LOG_FILE"

# Enviar resumen por Telegram
MSG="✅ Mantenimiento Fedora VM completado en $(hostname) - $(date)"
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" -d text="$MSG"

# Enviar archivo log
curl -s -F chat_id="$CHAT_ID" -F document=@"$LOG_FILE" \
     "https://api.telegram.org/bot$BOT_TOKEN/sendDocument"
