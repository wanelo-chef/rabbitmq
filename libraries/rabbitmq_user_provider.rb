require 'chef/provider'

class Chef::Provider::RabbitmqUser < Chef::Provider
  def load_current_resource
    @current_resource ||= Chef::Resource::RabbitmqUser.new(new_resource.name).tap do |cr|
      cr.password(new_resource.password)
    end
  end

  def action_create
    create_user
    set_permissions
  end

  private

  def create_user
    return if user.exists?

    cmd = "add_user #{user.name} '#{user.password}'"
    Chef::Log.info "Adding RabbitMQ user '#{user.name}'."
    RabbitMQ.ctl cmd
  end

  def set_permissions
    return if user.permissions_set?

    cmd = "set_permissions -p #{user.vhost} #{user.name} #{user.permissions}"
    Chef::Log.info "Adding RabbitMQ user '#{user.name}'."
    RabbitMQ.ctl cmd
  end

  def user
    new_resource
  end
end
