actions [:create, :delete]
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :database, :kind_of => String
attribute :password, :kind_of => String
attribute :nicename, :kind_of => String
attribute :email, :kind_of => String
attribute :url, :kind_of => String
attribute :status, :kind_of => String
attribute :display_name, :kind_of => String
attribute :role, :kind_of => String, :default => "editor"
attribute :level, :kind_of => String, :default => "7"

