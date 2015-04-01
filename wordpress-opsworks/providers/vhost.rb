use_inline_resources

action :create do
	name = new_resource.name
	docroot = new_resource.docroot
	source = new_resource.source
	aliases = new_resource.aliases
	themes = new_resource.themes
	plugins = new_resource.plugins

	db_name = "wp_#{name}"
	content_dir = "#{node[:wordpress_opsworks][:user_dir]}/#{name}"
	content_url = "//#{name}/wp-content"
	plugin_dir = "#{content_dir}/plugins"
	plugin_url = "//#{name}/wp-plugin"

	directory docroot

	link "#{docroot}/wordpress" do
		to "#{node[:wordpress_opsworks][:app_dir]}"
	end

	# vhost user content directory
	directory content_dir
	directory "#{content_dir}/uploads"

	# symlink selected themes to vhost
	directory "#{content_dir}/themes"
	themes.each do |t|
		link "#{content_dir}/themes/#{t}" do
			to "#{node[:wordpress_opsworks][:content_dir]}/themes/#{t}"
		end
	end

	# symlink selected plugins to vhost
	directory "#{content_dir}/plugins"
	plugins.each do |p|
		link "#{content_dir}/plugins/#{p}" do
			to "#{node[:wordpress_opsworks][:content_dir]}/plugins/#{p}"
		end
	end

	file "#{docroot}/index.php" do
		content <<-EOH
<?php
define('WP_USE_THEMES', true);
require( dirname( __FILE__ ) . '/wordpress/wp-blog-header.php' );
		EOH
	end

	template "/etc/apache2/sites-enabled/#{name}.conf" do
		source "wordpress-vhost.conf.erb"
		variables ({
				:name => name,
				:aliases => aliases,
				:docroot => docroot,
				:content_dir => content_dir,
				:plugin_dir => plugin_dir
				})
	end

	template "#{docroot}/wp-config.php" do
		source "wp-site-config.php.erb"
		variables ({
				:db_name => db_name,
				:content_dir => content_dir,
				:content_url => content_url,
				:plugin_dir => plugin_dir,
				:plugin_url => plugin_url,
				:wpcontent_dir => node[:wordpress_opsworks][:content_dir]
				})
	end

	# TODO: templatize unique salts config

	# on vagrant, write an opsworks config
	if ::File.exists?("/vagrant") then
		file "#{node[:wordpress_opsworks][:content_dir]}/opsworks.php" do
			content <<-EOH
<?php
class OpsWorksDb {
	public $username = "root";
	public $password = "";
	public $host = "127.0.0.1";
	public $encoding = "utf8";
}
			EOH
		end
	end

	file "#{docroot}/.htaccess" do
		content <<-EOH
Options -Indexes
RewriteEngine on

# vhost-specific rewrite rules go here

RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]

# end rewrite rules
		EOH
	end

	siteurl = "http://#{name}:8080"
	home = "http://#{name}:8080"
	wordpress_opsworks_db db_name do
		siteurl siteurl
		home home
		database_file node[:wordpress_opsworks][:mysql][:schema_file]
	end

end

action :delete do
    raise "not implemented"
end
