# Mitnick Attack

https://www.macoratti.net/19/02/dock_imgfile1.htm

* Instalando o docker:
    - Na pasta ./server

        `docker build -t server:1.0 .`

    - Na pasta ./Xterminal

        `docker build -t xterminal:1.0 .`

    - Para ter certeza ue deu certo:

        `docker images`
        - Tem que aparecer as duas imagens

* Rodando os servidores:

    `docker run --name server -p 10000:222 server:1.0`

    `docker run --name xterminal -p 10001:222 terminal:1.0`

* Entrando nos dockers:
    - Em outros novos terminais:
    
        `docker exec -it server /bin/bash`

        `docker exec -it xterminal /bin/bash`
    
* Rede
    Aprentemente o Docker cria uma subrede para rodar os containers
    - No meu caso ficou assim:

        server:     172.17.0.2
        
        xterminal:  172.17.0.3