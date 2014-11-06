include_recipe 'rabbitmq::package'
include_recipe 'rabbitmq::mgmt_console'
include_recipe 'rabbitmq::rabbitmqadmin'

service 'epmd' do
  action :enable
end

service 'rabbitmq' do
  action :enable
end

ruby_block 'wait for rabbitmq to start' do
  block do
    hostname = node.name.split('.').first
    RabbitMQ.ctl('wait /var/db/rabbitmq/mnesia/rabbit@%s.pid' % hostname)
  end
end
