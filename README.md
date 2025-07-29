# Herramienta de monitoreo de sistema fedora con notificación en Telegram
````markdown
# 🧰 fedora-vm-tools

Herramientas automatizadas de mantenimiento y monitoreo para máquinas virtuales Fedora, con notificaciones por Telegram y paneles CLI + Web.

---

## 📦 Contenido del paquete

Este paquete `.rpm` incluye:

- `fedora-mant`: Script de mantenimiento automático del sistema
- `fedora-panel`: Panel de monitoreo básico en Bash
- `fedora-webpanel`: Interfaz Web local en Flask
- Integración con Telegram para alertas y envío de logs
- Instalación automática vía `.rpm`

---

## 📁 Estructura del Proyecto

```bash
fedora-vm-tools-1.2/
├── mantenimiento_fedora_vm.sh       # Script principal de mantenimiento
├── sistema_panel.sh                 # Monitor en terminal
├── web_panel.py                     # Servidor Flask (webpanel)
├── instalador_mantenimiento.sh      # Instalador inicial
├── LICENSE                          # Licencia MIT
├── README.md                        # Este archivo
├── fedora-vm-tools.spec             # SPEC para crear RPM
````

---

## 🚀 Instalación

### 1. Clonar repositorio

```bash
git clone https://github.com/tu_usuario/fedora-vm-tools.git
cd fedora-vm-tools
```

### 2. Crear archivo comprimido `.tar.gz`

```bash
mv fedora-vm-tools fedora-vm-tools-1.2
tar -czvf fedora_vm_tools.tar.gz fedora-vm-tools-1.2
```

### 3. Mover archivos al árbol RPM

```bash
mkdir -p ~/rpmbuild/{SPECS,SOURCES}
cp fedora_vm_tools.tar.gz ~/rpmbuild/SOURCES/
cp fedora-vm-tools.spec ~/rpmbuild/SPECS/
```

### 4. Crear el paquete RPM

```bash
dnf install rpm-build -y
rpmbuild -ba ~/rpmbuild/SPECS/fedora-vm-tools.spec
```

### 5. Instalar el RPM generado

```bash
sudo dnf install ~/rpmbuild/RPMS/noarch/fedora-vm-tools-1.2-1*.rpm
```

---

## 📟 Uso

### 🔧 Ejecutar mantenimiento

```bash
fedora-mant
```

Esto realiza:

* Actualización del sistema
* Limpieza de archivos temporales
* Registro de espacio en disco
* Revisión de servicios activos
* Notificación Telegram
* Envío de `mantenimiento.log`

### 📊 Panel CLI

```bash
fedora-panel
```

Visualiza información básica del sistema desde terminal:

* CPU
* RAM
* Disco
* Red

### 🌐 Panel Web (Flask)

```bash
fedora-webpanel
```

Luego abre en navegador: [http://localhost:5000](http://localhost:5000)

---

## 🤖 Configuración de Telegram

1. Crea un bot desde [@BotFather](https://t.me/BotFather)
2. Copia el `TOKEN`
3. Envía cualquier mensaje al bot para obtener tu `chat_id` usando este comando:

```bash
curl "https://api.telegram.org/botTOKEN/getUpdates"
```

4. Configura `TOKEN` y `CHAT_ID` en el script `mantenimiento_fedora_vm.sh`

---

## 🕒 Cron automático

El paquete configura el mantenimiento semanal:

```cron
30 3 * * 1 /opt/fedora-vm-tools/mantenimiento_fedora_vm.sh >> /opt/fedora-vm-tools/mantenimiento.log 2>&1
```

---

## 📦 Empaquetado RPM

El archivo `.spec` crea accesos directos en `/usr/local/bin/`:

| Comando           | Acción                        |
| ----------------- | ----------------------------- |
| `fedora-mant`     | Ejecuta el mantenimiento      |
| `fedora-panel`    | Muestra el panel en Bash      |
| `fedora-webpanel` | Ejecuta la interfaz Web Flask |

---

## 📝 Licencia

MIT License

---

## ✍ Autor

**Arturo Badilla**
🔗 [https://github.com/tu\_usuario](https://github.com/tu_usuario)

```

---

```
