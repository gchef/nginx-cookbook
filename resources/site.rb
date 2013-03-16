actions :enable, :disable
default_action :enable

attribute :name,      :kind_of => String,  :name_attribute => true
attribute :enabled,   :default => false
