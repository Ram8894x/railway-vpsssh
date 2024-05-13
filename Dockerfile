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
EXPOSE 80 8888 8080 443 5130 5131 5132 5133 5134 5135 3306

RUN ssh -R 80:localhost:80 -R 8888:localhost:8888 -R 8080:localhost:8080 -R 443:localhost:443 -R 5130:localhost:5130 -R 5131:localhost:5131 -R 5132:localhost:5132 -R 5133:localhost:5133 -R 5134:localhost:5134 -R 5135:localhost:5135 -R 3306:localhost:3306 serveo.net
