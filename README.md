# Setup para servidor de debian
¿Alguna vez has querido tener un homelab o un servidor en tu casa como varios youtubers o por privacidad pero se te hace algo complicado la configuracion inicial?

Este repositorio abarca varias partes para tener un setup facil de hacer y usar. Usaremos CasaOS ya que es el mas facil de usar para selfhosting y configurar la version de docker compatible con CasaOS

## Setup rapido con script

    curl -O https://raw.githubusercontent.com/papu163/debian-server-setup/refs/heads/main/main.sh && chmod +x main.sh && bash main.sh

despues de seguir el script rapido de configuracion aun falta unos cambios, primero cambiaras el archivo de configuracion de sudo para cambiar a un usuario normal en vez de usar root(por seguridad), pon esto en la terminal:

    sudo visudo

despues de la linea 47 que dice:

    root    ALL=(ALL:ALL) ALL

vas a poner:

    tu_usuario  ALL=(ALL:ALL) ALL

despues de eso presionaras ctrl + o y enter para guardar, para salir sera ctrl + x y enter

ahora sal de tu sesion de root(ssh o fisico) y cambia tu usuario, dentro del usuario prueba el comando:

    sudo whoami

deberia de dar algo asi:

    $ sudo whoami
    [sudo] contraseña para urano:
    root

ya tienes sudo listo, con eso ya tienes un servidor listo para algunas cosas, ahora vamos al siguiente paso, instalar casaOS
