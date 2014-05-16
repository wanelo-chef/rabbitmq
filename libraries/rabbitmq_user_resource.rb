require 'chef/resource'

class Chef
  class Resource
    class RabbitmqUser < Chef::Resource
      include Chef::Mixin::ShellOut

      def initialize(name, run_context=nil)
        super
        @resource_name = :rabbimq_user
        @provider = Chef::Provider::RabbitmqUser
        @action = :create
        @allowed_actions = [:create]
      end

      def name(arg=nil)
        set_or_return(:name, arg, kind_of: String)
      end

      def password(arg=nil)
        set_or_return(:password, arg, kind_of: String)
      end

      def exists?
        cmd = shell_out!("su - rabbitmq -c 'rabbitmqctl list_users | grep #{name}'", valid_exit_codes: [0, 1])
        cmd.status == 0
      end
    end
  end
end
