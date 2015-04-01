include_recipe "apache2"

package "php5"
package "php5-mysql"

apache_module "rewrite"

link "/etc/apache2/sites-enabled/000-default" do
	action :delete
	notifies :reload, "service[apache2]", :delayed
end

package "mysql-server-5.5"
