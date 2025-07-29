# Estructura RPM: fedora-vm-tools
# ----------------------------------
# Este es un SPEC File que empaqueta:
# - Scripts de mantenimiento
# - Panel Bash
# - Web GUI en Flask

Name:           fedora-vm-tools
Version:        1.1
Release:        1%{?dist}
Summary:        Herramientas de mantenimiento, monitoreo y panel web para Fedora VM

License:        MIT
URL:            https://github.com/ARTAA123/fedora-vm-tools
Source0:        fedora_vm_tools.tar.gz

BuildArch:      noarch
Requires:       curl, coreutils, cronie, util-linux, iproute, lm_sensors, python3-flask

%description
Incluye:
- Mantenimiento automático del sistema con logs por Telegram
- Panel Bash
- Panel Web local (Flask) para monitoreo desde navegador

%prep
%setup -q

%build
# No se compila nada

%install
mkdir -p %{buildroot}/opt/fedora-vm-tools
cp -a * %{buildroot}/opt/fedora-vm-tools

# Symlinks
mkdir -p %{buildroot}/usr/local/bin
ln -s /opt/fedora-vm-tools/sistema_panel.sh %{buildroot}/usr/local/bin/fedora-panel
ln -s /opt/fedora-vm-tools/mantenimiento_fedora_vm.sh %{buildroot}/usr/local/bin/fedora-mant
ln -s /opt/fedora-vm-tools/web_panel.py %{buildroot}/usr/local/bin/fedora-webpanel

%post
# Registrar mantenimiento con cron
CRON_LINE="30 3 * * 1 /opt/fedora-vm-tools/mantenimiento_fedora_vm.sh >> /opt/fedora-vm-tools/mantenimiento.log 2>&1"
(crontab -l 2>/dev/null | grep -v "mantenimiento_fedora_vm"; echo "$CRON_LINE") | crontab -

# Instrucciones para iniciar web local (puede ser agregado como systemd opcional)
echo "Puedes ejecutar el panel web con: fedora-webpanel"

%files
%license LICENSE
%doc README.md
/opt/fedora-vm-tools/*
/usr/local/bin/fedora-panel
/usr/local/bin/fedora-mant
/usr/local/bin/fedora-webpanel

%changelog
* Tue Jul 29 2025 Jorge Badilla <jbadillae@uned.ac.cr> - 1.1-1
- Agregado panel web con Flask y comandos simplificados para el usuario
