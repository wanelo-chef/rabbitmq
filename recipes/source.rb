include_recipe 'rabbitmq::dependencies'

helper = RabbitMQ::Helper.new(node)

remote_file helper.tar_file do
  source helper.remote_tar_file
end

execute 'untar rabbitmq' do
  command %[tar xvzf #{helper.tar_file} #{helper.source_directory}]
end

execute 'configure rabbitmq' do
  command %{./configure}
  cwd helper.source_directory
end
