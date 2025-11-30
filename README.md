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

    tu_usuario_de_instalacion  ALL=(ALL:ALL) ALL

despues de eso presionaras ctrl + o y enter para guardar, para salir sera ctrl + x y enter

ahora sal de tu sesion de root con el comando exit y cambia tu usuario a el usuario creado en la instalacion de debian, dentro del usuario prueba el comando:

    sudo whoami

deberia de dar algo asi:

    $ sudo whoami
    [sudo] contraseña para urano:
    root

ya tienes sudo listo, con eso ya tienes un servidor listo para algunas cosas, ahora vamos al siguiente paso, instalar casaOS

## CasaOS

Ahora empezaremos con casaOS, CasaOS sirve para gestionar contenedores de docker de forma sencilla sin mucha complicacion como lo seria normalmente pero la instalacion basica de casOS lamentablemente tiene un error donde docker no funciona correctamente y se tiene que editar configuracion en systemd, abarcaremos ese error para configurarlo. Iniciaremos poniendo en la terminal(recomiendo ya empezar a usar ssh desde aca):

    curl -fsSL https://get.casaos.io | sudo bash

ya esta instalado pero te daras cuenta que al ir a donde te manda CasaOS no aparece ni la app store de casaOS y dice "Failed to load apps". La solucion es simple, pon el comando: 

    sudo systemctl edit docker.service

esto abrira el archivo de configuracion de docker en systemd, deberas de modificarlo para que quede asi:

    ### Editing /etc/systemd/system/docker.service.d/override.conf
    ### Anything between here and the comment below will become the contents of the drop-in file

    [Service]
    Environment=DOCKER_MIN_API_VERSION=1.24

    ### Edits below this comment will be discarded

ahora solo pon:

    sudo systemctl restart docker

Listo, ahora en teoria deberia de funcionar, si no funciona checa este link:

    https://github.com/IceWhaleTech/CasaOS/issues/2443
    
