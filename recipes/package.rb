include_recipe 'rabbitmq::dependencies'

package 'rabbitmq' do
  notifies :enable, 'service[epmd]'
  notifies :enable, 'service[rabbitmq]'
end

service 'epmd'
service 'rabbitmq'
