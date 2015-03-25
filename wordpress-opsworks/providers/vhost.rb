use_inline_resources

action :create do
	name = new_resource.name
	docroot = new_resource.docroot
	source = new_resource.source
	aliases = new_resource.aliases

	db_name = "wp_#{name}"
	content_dir = "#{node[:wordpress_opsworks][:content_dir]}/#{name}"
	content_url = "//#{name}/wp-content"

	directory docroot

	link "#{docroot}/wordpress" do
		to "#{node[:wordpress_opsworks][:app_dir]}"
	end

	link content_dir do
		to "#{node[:wordpress_opsworks][:app_dir]}/wp-content"
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
				:content_dir => content_dir
				})
	end

	template "#{docroot}/wp-config.php" do
		source "wp-site-config.php.erb"
		variables ({
				:db_name => db_name,
				:content_dir => content_dir,
				:content_url => content_url
				})
	end

	# TODO: templatize unique salts config

	# on vagrant, write an opsworks config
	if ::File.exists?("/vagrant") then
		file "#{docroot}/opsworks.php" do
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
