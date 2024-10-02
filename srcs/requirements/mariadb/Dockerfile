FROM	debian:bullseye

RUN	apt-get update

COPY init-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-db.sh

ENTRYPOINT [ "init-db.sh" ]
CMD	["mariadbd"]
