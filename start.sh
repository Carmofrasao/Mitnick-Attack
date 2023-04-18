#!/bin/bash

chmod +x startup.sh

# constroi imagem docker
docker build --rm -t base:1.0 Containers/ 

# se container nao existe, cria um com base na imagem
if [ "$(docker ps -aq --filter name=server)" ]; then
    echo "Server container already exists"
    docker start server
else
    echo "Server container doesnt exists, creating"
    docker run --name server -p 10000:222 base:1.0&
fi

if [ "$(docker ps -aq --filter name=xterminal)" ]; then
    echo "Xterminal container already exists"
    docker start xterminal
else
    echo "Xterminal container doesnt exists, creating"
    docker run --name xterminal -p 10001:222 base:1.0&
fi


gnome-terminal \
    --tab --title="xterminal" --command "docker exec -it xterminal /bin/bash" \
    --tab --title="server" --command "docker exec -it server /bin/bash" &> /dev/null

# cansei
id_xterm=$(docker ps --filter name="xterminal" --format "{{.ID}}")
id_server=$(docker ps --filter name="server" --format "{{.ID}}")

echo "SETAR CONTAINER"
echo -e "\t\tIP\t\t\tnome\t\tId"
echo -e "$(docker inspect server | grep -m 1 IPAddress\"\:)\tserver\t\t$id_server"
echo -e "$(docker inspect xterminal | grep -m 1 IPAddress\"\:)\txterminal\t$id_xterm"

# bash container.sh id_xterm $id_xterm > _xterm.sh
# bash container.sh id_server $id_server > _server.sh

# cat _xterm.sh _server.sh
