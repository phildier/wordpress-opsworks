# directory in which to install wordpress app files
default[:wordpress_opsworks][:app_dir] = "/opt/wordpress"

# user uploads and content
default[:wordpress_opsworks][:content_dir] = "/opt/content"

# wordpress virtual hosts
default[:wordpress_opsworks][:virtual_dir] = "/opt/virtual"
default[:wordpress_opsworks][:vhosts] = {}

# wordpress files and dirs to link into vhosts
# "from (shared app dir)" => "to (vhost docroot)"
default[:wordpress_opsworks][:links] = {
	"index.php" => "index.php",
	"wp-activate.php" => "wp-activate.php",
	"wp-admin" => "wp-admin",
	"wp-blog-header.php" => "wp-blog-header.php",
	"wp-comments-post.php" => "wp-comments-post.php",
	"wp-content/index.php" => "wp-content/index.php",
	"wp-content/plugins" => "wp-content/plugins",
	"wp-content/themes" => "wp-content/themes",
	"wp-cron.php" => "wp-cron.php",
	"wp-includes" => "wp-includes",
	"wp-links-opml.php" => "wp-links-opml.php",
	"wp-load.php" => "wp-load.php",
	"wp-login.php" => "wp-login.php",
	"wp-mail.php" => "wp-mail.php",
	"wp-settings.php" => "wp-settings.php",
	"wp-signup.php" => "wp-signup.php",
	"wp-trackback.php" => "wp-trackback.php",
	"xmlrpc.php" => "xmlrpc.php"
}
