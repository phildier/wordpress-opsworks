use_inline_resources

action :create do
	name = new_resource.name
	docroot = new_resource.docroot
	source = new_resource.source
	aliases = new_resource.aliases

	directory docroot

	link "#{docroot}/wordpress" do
		to "#{node[:wordpress_opsworks][:app_dir]}"
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
				:docroot => docroot
				})
	end

	db_name = "wp_#{name}"
	content_dir = "#{node[:wordpress_opsworks][:content_dir]}/#{name}"
	content_url = "//#{name}/wp-content"

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
RewriteRule ^(/)?$ wordpress [L]
		EOH
	end

end

action :delete do
    raise "not implemented"
end
