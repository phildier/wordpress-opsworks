use_inline_resources

action :create do
	name = new_resource.name
	docroot = new_resource.docroot
	source = new_resource.source
	aliases = new_resource.aliases

	directory docroot

	dirs = Set.new
	node[:wordpress_opsworks][:links].each do |from_shared,to_vhost|
		dirs << s = ::File.dirname(to_vhost) unless s == "."
	end

	dirs.each do |subdir|
		directory "#{docroot}/#{subdir}"
	end

	node[:wordpress_opsworks][:links].each do |from_shared,to_vhost|
		link "#{docroot}/#{to_vhost}" do 
			to "#{node[:wordpress_opsworks][:app_dir]}/#{from_shared}"
		end
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

	template "#{docroot}/wp-config.php" do
		source "wp-config.php.erb"
		variables ({
				:name => db_name
				})
	end

	# TODO: templatize unique salts config

end

action :delete do
    raise "not implemented"
end
