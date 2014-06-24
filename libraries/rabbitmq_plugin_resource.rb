require 'chef/resource'

class Chef::Resource::RabbitmqPlugin < Chef::Resource
  include Chef::Mixin::ShellOut

  def initialize(name, run_context=nil)
    super
    @resource_name = :rabbitmq_plugin
    @provider = Chef::Provider::RabbitmqPlugin
    @action = :enable
    @allowed_actions = [:enable]
  end

  def name(arg=nil)
    set_or_return(:name, arg, kind_of: String)
  end

  def enabled?
    !!RabbitMQ.plugins("list -e #{name}").stdout.match(/ #{name} /)
  end
end
