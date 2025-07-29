#!/usr/bin/env python3
from flask import Flask, render_template_string
import subprocess

app = Flask(__name__)

HTML = """
<!DOCTYPE html>
<html>
<head>
    <title>Fedora VM - Panel de Estado</title>
    <meta charset="utf-8">
    <style>
        body { font-family: Arial, sans-serif; background: #1e1e1e; color: #e0e0e0; padding: 20px; }
        pre { background: #2e2e2e; padding: 15px; border-radius: 8px; overflow-x: auto; }
        h1 { color: #00bfff; }
    </style>
</head>
<body>
    <h1>🖥️ Panel de Estado - Fedora VM</h1>
    <h2>🧠 Uso de CPU</h2>
    <pre>{{ cpu }}</pre>
    <h2>💾 Uso de Memoria</h2>
    <pre>{{ memory }}</pre>
    <h2>📦 Espacio en Disco</h2>
    <pre>{{ disk }}</pre>
    <h2>⚠️ Servicios Fallando</h2>
    <pre>{{ failed_services }}</pre>
    <h2>🌡️ Temperatura</h2>
    <pre>{{ temp }}</pre>
</body>
</html>
"""

def run_cmd(cmd):
    try:
        return subprocess.check_output(cmd, shell=True, text=True).strip()
    except:
        return "Error al ejecutar el comando."

@app.route("/")
def dashboard():
    cpu = run_cmd("top -bn1 | grep 'Cpu(s)'")
    memory = run_cmd("free -h")
    disk = run_cmd("df -h /")
    failed_services = run_cmd("systemctl --failed --no-pager")
    temp = run_cmd("sensors")  # Requiere lm_sensors

    return render_template_string(HTML, cpu=cpu, memory=memory, disk=disk, failed_services=failed_services, temp=temp)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
