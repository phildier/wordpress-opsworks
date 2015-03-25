actions [:create, :delete]
default_action :create

attribute :database, :kind_of => String, :name_attribute => true
attribute :siteurl, :kind_of => String
attribute :home, :kind_of => String
attribute :blogname, :kind_of => String
attribute :blogdescription, :kind_of => String
attribute :users_can_register, :kind_of => String
attribute :admin_email, :kind_of => String

