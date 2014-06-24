require 'chef/provider'
require 'fileutils'

class Chef::Provider::RabbitmqPlugin < Chef::Provider
  def load_current_resource
    @current_resource ||= Chef::Resource::RabbitmqPlugin.new(new_resource.name)
  end

  def action_enable
    unless new_resource.enabled?
      Chef::Log.info "Enabling RabbitMQ plugin '#{new_resource.name}'."
      RabbitMQ.plugins "enable #{new_resource.name}"
      new_resource.updated_by_last_action(true)
    end
  end

  def action_disable
    if new_resource.enabled?
      Chef::Log.info "Disabling RabbitMQ plugin '#{new_resource.name}'."
      RabbitMQ.plugins "disable #{new_resource.name}"
      new_resource.updated_by_last_action(true)
    end
  end
end
