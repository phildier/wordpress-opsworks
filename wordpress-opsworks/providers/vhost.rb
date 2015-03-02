use_inline_resources

action :create do
	docroot = new_resource.name
	source = new_resource.source

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

end

action :delete do
    raise "not implemented"
end
