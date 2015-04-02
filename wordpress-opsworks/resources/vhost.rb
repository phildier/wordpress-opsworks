actions [:create, :delete]
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :docroot, :kind_of => String
attribute :source, :kind_of => String
attribute :aliases, :kind_of => Array, :default => []
attribute :themes, :kind_of => Array, :default => ["twentyfifteen"]
attribute :plugins, :kind_of => Array, :default => []
attribute :debug, :kind_of => String, :default => "false"
