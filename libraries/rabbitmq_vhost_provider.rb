require 'chef/provider'

class Chef::Provider::RabbitmqVhost < Chef::Provider
  def load_current_resource
    @current_resource ||= Chef::Resource::RabbitmqVhost.new(new_resource.name)
  end

  def action_create
    unless new_resource.exists?
      cmd = "rabbitmqctl add_vhost /#{new_resource.name}"
      execute "creating rabbitmq vhost #{new_resource.name}" do
        command %{su - rabbitmq -c "#{cmd}"}
        Chef::Log.info "Adding RabbitMQ vhost '#{new_resource.name}'."
      end
    end
  end
end
