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
    set_tags
  end

  private

  def create_user
    return if user.exists?

    Chef::Log.info "Adding RabbitMQ user '#{user.name}'."
    RabbitMQ.ctl "add_user #{user.name} '#{user.password}'"
    user.updated_by_last_action(true)
  end

  def set_permissions
    return if user.permissions_set?

    Chef::Log.info "Adding RabbitMQ user permissions '#{user.name}', #{user.command_line_permissions}, vhost=#{user.vhost}"
    RabbitMQ.ctl %Q{set_permissions -p #{user.vhost} "#{user.name}" #{user.command_line_permissions}}
    user.updated_by_last_action(true)
  end

  def set_tags
    return if user.tags.empty? || user.tags_set?

    Chef::Log.info "Setting user tags '#{user.name}'."
    RabbitMQ.ctl %Q{set_user_tags #{user.name} #{user.tags.join(' ')}}
    user.updated_by_last_action(true)
  end

  def user
    new_resource
  end
end
