require 'chef/provider'

class Chef
  class Provider
    class RabbitmqUser < Chef::Provider
      def load_current_resource
        @current_resource ||= Chef::Resource::RabbitmqUser.new(new_resource.name).tap do |cr|
          cr.password(new_resource.password)
        end
      end

      def action_create
        if new_resource.exists?
        else
          cmd = "rabbitmqctl add_user #{new_resource.name} '#{new_resource.password}'"
          execute "creating rabbitmq user #{new_resource.name}" do
            command %{su - rabbitmq -c "#{cmd}"}
            Chef::Log.info "Adding RabbitMQ user '#{new_resource.name}'."
          end
        end
      end
    end
  end
end
