# Docker setup

## maquina local

primeira vez roda start.sh duas vezes. \
`docker stop <nome>` \
`docker rm <nome>`

> **informacao de saida usa pra preencher os containers**

## no container

> da pra automatizar, mas da pra fazer na mao tb

adduser \<usuario> \
passwd \<usuario> \
$ digita senha 123 \
adicionar IP NOME remoto em /etc/hosts nos dois containers \
adicionar IP NOME remoto em /root/.rhosts

- Caso queira logar com rsh\
  `rhs IP_REMOTO -l <usuario>`

# Mitnick Attack

https://www.macoratti.net/19/02/dock_imgfile1.htm

- Instalando o docker:

  - Na pasta ./server

    `docker build --rm -t server:1.0 .`

  - Na pasta ./Xterminal

    `docker build --rm -t xterminal:1.0 .`

  - Para ter certeza ue deu certo:

    `docker image ls`

    - Tem que aparecer as duas imagens

- Rodando os servidores:

  `docker run --name server -p 10000:222 server:1.0`

  `docker run --name xterminal -p 10001:222 xterminal:1.0`

- Entrando nos dockers:

  - Em outros novos terminais:

    `docker exec -it server /bin/bash`

    `docker exec -it xterminal /bin/bash`

- Rede

  Aprentemente o Docker cria uma subrede para rodar os containers

  - No meu caso ficou assim:

    server: 172.17.0.2

    xterminal: 172.17.0.3

<!-- Daqui para baixo nada é garantido -->

- Adicionando nome de host em /etc/hosts

  - No servidor:

        `echo "127.0.0.1    localhost

    ::1 localhost ip6-localhost ip6-loopback
    fe00::0 ip6-localnet
    ff00::0 ip6-mcastprefix
    ff02::1 ip6-allnodes
    ff02::2 ip6-allrouters
    172.17.0.2 <host_server>
    172.17.0.3 <host_client>" > /etc/hosts`

  - No cliente:

        `echo "127.0.0.1    localhost

    ::1 localhost ip6-localhost ip6-loopback
    fe00::0 ip6-localnet
    ff00::0 ip6-mcastprefix
    ff02::1 ip6-allnodes
    ff02::2 ip6-allrouters
    172.17.0.3 <host_client>
    172.17.0.2 <host_server>" > /etc/hosts`

- Adicionando usuários em ~/.rhosts:

  - No servidor:

    `echo "172.17.0.3      <host_client>" > ~/.rhosts`

  - No cliente:

    `echo "172.17.0.2   <host_server>" > ~/.rhosts`
