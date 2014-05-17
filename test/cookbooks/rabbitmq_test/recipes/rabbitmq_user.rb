include_recipe 'rabbitmq'

rabbitmq_vhost 'thing' do
end

rabbitmq_user 'my-user' do
  password 'bladerljkrljl'
end

execute 'manually create a rabbitmq user' do
  command %{
    su - rabbitmq -c "rabbitmqctl add_user preexisting_user 'password'"
  }
  not_if { RabbitMQ.ctl('list_users').stdout.include?('preexisting_user') }
end

rabbitmq_user 'preexisting_user' do
  password 'password'
end

rabbitmq_user 'user_with_permissions' do
  password 'password'
  vhost '/thing'
  permissions '.* .* .*'
end

