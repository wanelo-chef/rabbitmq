%w(
  rabbitmq_management
  rabbitmq_management_visualiser
).each do |plugin|
  rabbitmq_plugin plugin do
    action :enable
    notifies :restart, "service[rabbitmq]", :immediately
  end
end
