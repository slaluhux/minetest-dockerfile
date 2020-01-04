FROM debian:latest

RUN apt update && apt install openssh-server locales -y && ssh-keygen -A  

RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen  
RUN echo 'zh_CN.UTF-8 UTF-8' >> /etc/locale.gen 
RUN locale-gen

RUN apt install build-essential cmake git wget curl unzip tmux screen \
	sqlite3 libsqlite3-dev libz-dev libirrlicht-dev \
	gettext libncursesw5-dev bash-completion pwgen vim zsh -y 

CMD useradd -m -u 1400 -s /bin/zsh -p $(pwgen -s 30 | head -n 1) minetest \
	&& mkdir /run/sshd \
	&& /usr/sbin/sshd -D
