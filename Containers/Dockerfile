# define a imagem base
FROM debian:latest
# define o mantenedor da imagem
LABEL maintainer="grupoSeguro"
# Atualiza a imagem com os pacotes
RUN apt-get update && apt-get upgrade -y
# Instala o NGINX para testar
RUN apt-get install nginx vim dsniff net-tools rsh-redone-client rsh-redone-server tcpdump hping3 iputils-ping -y
# Expoe a porta 222
EXPOSE 222
# Comando para iniciar o NGINX no Container
CMD ["nginx", "-g", "daemon off;"]