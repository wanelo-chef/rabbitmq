require 'chef/resource'

class Chef::Resource::RabbitmqVhost < Chef::Resource
  include Chef::Mixin::ShellOut

  def initialize(name, run_context=nil)
    super
    @resource_name = :rabbitmq_vhost
    @provider = Chef::Provider::RabbitmqVhost
    @action = :create
    @allowed_actions = [:create]
  end

  def name(arg=nil)
    set_or_return(:name, arg, kind_of: String)
  end

  def exists?
    cmd = RabbitMQ.ctl("list_vhosts | grep #{name}", returns: [0, 1])
    cmd.status == 0
  end
end
