#!/bin/bash

if [ $EUID -ne 0 ]; then
    echo "Debes ejecutar este script como root"
    exit 1
fi

if ! command -v apache2 &> /dev/null; then
    echo "Instalando Apache..."
    apt-get update
    apt-get install apache2 -y
fi

if ! command -v git &> /dev/null; then
    echo "Instalando Git..."
    apt-get install git -y
fi

echo "Clonando el repositorio netlifyDeploy..."
git clone https://github.com/MarcoSavarin0/netlifyDeploy /tmp/netlifyDeploy

echo "Moviendo archivos al directorio de Apache..."
cp -r /tmp/netlifyDeploy/* /var/www/html/

echo "Configurando permisos para Apache..."
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

echo "Habilitando Apache..."
systemctl enable apache2
systemctl restart apache2

echo "Abriendo el puerto 80 en el firewall..."
ufw allow 80/tcp

echo "Configuración completada. Ahora puedes intentar acceder a tu página web."
