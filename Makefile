# ビルドと起動
up:
	mkdir -p /home/oaoba/data/wordpress_files
	mkdir -p /home/oaoba/data/db-data
	sudo docker-compose -f srcs/docker-compose.yml up --build -d

# 停止とコンテナの削除
down:
	docker-compose -f srcs/docker-compose.yml down

# ボリュームを含め,全て削除
clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v 

fclean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v \
	&& sudo rm -rf /home/oaoba/data/db-data/* /home/oaoba/data/wordpress_files*

# コンテナのログを表示
logs:
	docker-compose -f srcs/docker-compose.yml logs

# 実行中のコンテナのみ表示
ps:
	docker-compose -f srcs/docker-compose.yml ps

nginx:
	docker exec -it nginx bash

wordpress:
	docker exec -it wordpress bash

mariadb:
	docker exec -it mariadb bash

reboot_nginx:
	docker exec -it nginx "/usr/sbin/nginx -s reload"

.PHONY: up down clean logs ps nginx wordpress mariadb reboot_nginx
