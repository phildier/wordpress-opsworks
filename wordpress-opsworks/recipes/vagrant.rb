package "apache2"

link "/etc/apache2/sites-enabled/000-default" do
	action :delete
	notifies :reload, "service[apache2]", :delayed
end

service "apache2" do
	action [:start,:enable]
end
