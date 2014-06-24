include_recipe 'rabbitmq'

rabbitmq_plugin 'rabbitmq_management' do
  action :enable
end
