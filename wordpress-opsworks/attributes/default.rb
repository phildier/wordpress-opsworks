# cached downloads
default[:wordpress_opsworks][:cache_dir] = "/vagrant/cache"

# directory in which to install wordpress app files
default[:wordpress_opsworks][:app_dir] = "/opt/wordpress"

# global themes and plugins
default[:wordpress_opsworks][:content_dir] = "/opt/content"

# user uploads and content
default[:wordpress_opsworks][:user_dir] = "/opt/user"

# wordpress virtual hosts
default[:wordpress_opsworks][:virtual_dir] = "/opt/virtual"
default[:wordpress_opsworks][:vhosts] = {}

# mysql server 
default[:wordpress_opsworks][:mysql][:host] = "127.0.0.1"
default[:wordpress_opsworks][:mysql][:username] = "root"
default[:wordpress_opsworks][:mysql][:password] = ""

default[:wordpress_opsworks][:default_themes] = ["twentyfifteen"]
default[:wordpress_opsworks][:default_plugins] = []
default[:wordpress_opsworks][:default_aliases] = []

# s3 stuff
default[:wordpress_opsworks][:s3][:bucket] = nil
default[:wordpress_opsworks][:s3][:id] = nil
default[:wordpress_opsworks][:s3][:key] = nil
