actions [:create,:delete]
default_action :create

attribute :dest, :kind_of => String, :name_attribute => true
attribute :source, :kind_of => String
attribute :create_dir, :kind_of => [TrueClass, FalseClass]
