require 'chef/resource'

class Chef
  class Resource
    class RabbitmqUser < Chef::Resource
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
    end
  end
end
