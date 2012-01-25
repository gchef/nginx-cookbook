actions :add, :remove

attribute :name,             :kind_of => String,  :name_attribute => true
attribute :type,             :kind_of => String,  :default => "proxy",     :equal_to => %w[proxy uwsgi]
attribute :upstream,         :kind_of => String
attribute :tcp_connection,   :kind_of => String
attribute :unix_connection,  :kind_of => String
attribute :domains,          :kind_of => String
attribute :public_path,      :kind_of => String

def initialize(*args)
  super
  @action = :add
end
