FROM    debian:bullseye

RUN     apt-get update && apt install -y mariadb-server

COPY    init-db.sh /usr/local/bin/
RUN     chmod +x /usr/local/bin/init-db.sh

EXPOSE  3306

# ENTRYPOINTで初期化スクリプトを実行し、MariaDBデーモンを起動
ENTRYPOINT [ "/usr/local/bin/init-db.sh" ]
CMD     ["mariadbd"]
