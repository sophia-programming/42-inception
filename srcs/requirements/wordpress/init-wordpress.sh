#!/bin/sh

# wordpressのダウンロード
wp core download --path=/var/www/html/ --allow-root

# WordPressのインストール確認
if ! wp core is-installed --allow-root ; then
	cd /var/www/html

# wp-config.php ファイルを作成し、データベース接続情報を設定
	wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST" --allow-root

# WordPressをインストールし、サイトのURL, タイトル, 管理者アカウントを設定
	wp core install --url="$WORDPRESS_URL" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --allow-root

# 追加ユーザーの作成
	wp user create --url="$WORDPRESS_URL" "$WORDPRESS_USER_NAME" "$WORDPRESS_USER_EMAIL" --role="$WORDPRESS_USER_ROLE" --allow-root
fi

# 実行
exec "$@"
