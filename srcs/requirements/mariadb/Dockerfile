FROM    debian:bullseye

RUN     apt-get update && apt-get install -y mariadb-server

COPY    init-db.sh /usr/local/bin/
RUN     chmod +x /usr/local/bin/init-db.sh
RUN     service mariadb start && /usr/local/bin/init-db.sh

COPY    my.cnf /etc/mysql/my.cnf

EXPOSE  3306

CMD [ "mysqld_safe" ]
