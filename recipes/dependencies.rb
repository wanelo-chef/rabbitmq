include_recipe 'build-essential'
include_recipe 'erlang::package'
include_recipe 'python'

node['rabbitmq']['dependencies']['packages'].each do |pkg|
  package pkg
end
