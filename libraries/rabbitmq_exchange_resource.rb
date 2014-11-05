require 'chef/resource'

class Chef::Resource::RabbitmqExchange < Chef::Resource
  include Chef::Mixin::ShellOut

  def initialize(name, run_context=nil)
    super
    @resource_name = :rabbitmq_exchange
    @provider = Chef::Provider::RabbitmqExchange
    @action = :create
    @allowed_actions = [:create]
  end

  def name(arg=nil)
    set_or_return(:name, arg, kind_of: String)
  end

  def user(arg=nil)
    set_or_return(:user, arg, kind_of: String)
  end

  def password(arg=nil)
    set_or_return(:password, arg, kind_of: String)
  end

  def type(arg=nil)
    set_or_return(:type, arg, kind_of: String)
  end

  def vhost(arg=nil)
    set_or_return(:vhost, arg, kind_of: String)
  end

  def exists?
    !!RabbitMQ.ctl("list_exchanges -p #{vhost}").stdout.match(/^#{name} /)
  end
end
