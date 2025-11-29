# Setup para servidor de debian
Setup simple para debian, explicado tanto manualmente como con un script

## Setup rapido con script

    curl -O https://raw.githubusercontent.com/papu163/debian-server-setup/refs/heads/main/main.sh && chmod +x main.sh && bash main.sh

despues de seguir el script rapido de configuracion aun falta unos cambios, primero cambiaras el archivo de configuracion de sudo para cambiar a un usuario normal en vez de usar root(por seguridad), pon esto en la terminal:

    sudo visudo

despues de la linea 47 que dice:

    root    ALL=(ALL:ALL) ALL

vas a poner:

    tu_usuario  ALL=(ALL:ALL) ALL

despues de eso presionaras ctrl + o y enter para guardar, para salir sera ctrl + x y enter
