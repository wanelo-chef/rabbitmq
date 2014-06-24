require 'chef/provider'

class Chef::Provider::RabbitmqVhost < Chef::Provider
  def load_current_resource
    @current_resource ||= Chef::Resource::RabbitmqVhost.new(new_resource.name)
  end

  def action_create
    unless new_resource.exists?
      Chef::Log.info "Adding RabbitMQ vhost '#{new_resource.name}'."
      RabbitMQ.ctl "add_vhost /#{new_resource.name}"
    end
  end
end
