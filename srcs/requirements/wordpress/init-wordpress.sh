#!/bin/sh

# wordpressのダウンロード
wp core download --path=/var/www/html/ --allow-root

# WordPressのインストール確認
if ! wp core is-installed --path=/var/www/html --allow-root ; then
	cd /var/www/html

# wp-config.php ファイルを作成し、データベース接続情報を設定
	wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --allow-root

# WordPressをインストールし、サイトのURL, タイトル, 管理者アカウントを設定
	wp core install --url="$WORDPRESS_URL" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --allow-root

# 追加ユーザーの作成
	wp user create ${WORDPRESS_USER_NAME} ${WORDPRESS_USER_EMAIL} --user_pass=${WORDPRESS_USER_PASSWORD} --role=editor --allow-root
fi

# 実行
exec "$@"
