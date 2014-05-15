include_recipe 'rabbitmq::dependencies'

helper = RabbitMQ::Helper.new(node)

remote_file helper.tar_file do
  source helper.remote_tar_file
end

execute 'untar rabbitmq' do
  command %[tar xvzf #{helper.tar_file}]
  cwd File.dirname(helper.tar_file)
  not_if { File.directory?(helper.source_directory) }
end

execute 'make rabbitmq' do
  command %{make}
  cwd helper.source_directory
  environment helper.build_environment
end
