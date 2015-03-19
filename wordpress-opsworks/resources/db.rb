actions [:create, :delete]
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :siteurl, :kind_of => String
attribute :home, :kind_of => String
attribute :admin_username, :kind_of => String
attribute :admin_password, :kind_of => String
attribute :database_file, :kind_of => String
