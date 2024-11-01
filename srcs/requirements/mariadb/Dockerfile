FROM	debian:bullseye

RUN	apt-get update && apt install -y mariadb-server

COPY init-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-db.sh
RUN service mariadb start && /usr/local/bin/init-db.sh

ENTRYPOINT [ "init-db.sh" ]
CMD	["mariadbd"]
