include_recipe 'python'

cookbook_file '/opt/local/bin/rabbitmqadmin' do
  mode 0755
  cookbook 'rabbitmq'
end
