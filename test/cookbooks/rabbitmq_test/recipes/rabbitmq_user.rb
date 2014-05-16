include_recipe 'rabbitmq'

rabbitmq_user 'my-user' do
  password 'bladerljkrljl'
end

execute 'manually create a rabbitmq user' do
  command %{
    su - rabbitmq -c "rabbitmqctl add_user preexisting_user 'password'"
  }
end

rabbitmq_user 'preexisting_user' do
  password 'password'
end

