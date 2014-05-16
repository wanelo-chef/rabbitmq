include_recipe 'rabbitmq::dependencies'

helper = RabbitMQ::SourceHelper.new(node)

remote_file helper.tar_file do
  source helper.remote_tar_file
end

execute 'untar rabbitmq' do
  command %[tar xvzf #{helper.tar_file}]
  cwd File.dirname(helper.tar_file)
  not_if { File.directory?(helper.source_directory) }
end

execute 'patch rabbitmq source : sh' do
  command %{find . -type f | xargs sed -i 's^#!\/bin\/sh^#!\/usr\/xpg4\/bin\/sh^'}
  cwd helper.source_directory
  only_if { helper.requires_sh_patching? }
end

execute 'patch rabbitmq source : python' do
  command %{
    find . -type f | xargs sed -i 's^#!\/usr\/bin\/python^#!\/opt\/local\/bin\/python^'
    find . -type f | xargs sed -i 's^#!\/usr\/bin\/env python^#!\/opt\/local\/bin\/python^'
  }
  cwd helper.source_directory
  only_if { helper.requires_sh_patching? }
end

execute 'make rabbitmq' do
  command %{make}
  cwd helper.source_directory
  environment helper.build_environment
end
