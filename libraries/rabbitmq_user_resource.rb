require 'chef/resource'

class Chef::Resource::RabbitmqUser < Chef::Resource
  include Chef::Mixin::ShellOut

  def initialize(name, run_context=nil)
    super
    @resource_name = :rabbitmq_user
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

  def vhost(arg=nil)
    set_or_return(:vhost, arg, kind_of: String)
  end

  def permissions(arg=nil)
    set_or_return(:permissions, arg, kind_of: String)
  end

  def tags(arg=nil)
    set_or_return(:tags, arg, kind_of: Array, default: [])
  end

  def command_line_permissions
    unless permissions.nil? || permissions.empty?
      permissions.split.map { |p| %{"#{p}"} }.join " "
    end
  end

  def exists?
    Chef::Log.info "Checking for existence of RabbitMQ user #{name}"
    cmd = RabbitMQ.ctl("list_users | egrep '^#{name} '", returns: [0, 1])
    cmd.status == 0
  end

  def permissions_set?
    return true unless vhost
    return true unless permissions
    perms = RabbitMQ.ctl("list_permissions -p #{vhost} | grep #{name}", returns: [0, 1]).stdout
    perms == "#{name} #{permissions}"
  end
end
