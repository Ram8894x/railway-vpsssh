FROM debian:stable

RUN apt update -y > /dev/null 2>&1 && apt upgrade -y > /dev/null 2>&1
ARG Password
ENV Password=${Password}
RUN apt install openssh-server wget unzip -y > /dev/null 2>&1



# Configure SSH
RUN mkdir /run/sshd
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo root:${Password}|chpasswd
RUN service ssh start

# Expose ports
EXPOSE 80 22 8888 8080 443 5130 5131 5132 5133 5134 5135 3306
