require 'chef/provider'

class Chef::Provider::RabbitmqExchange < Chef::Provider

  def load_current_resource
    @current_resource ||= Chef::Resource::RabbitmqExchange.new(new_resource.name).tap do |cr|
      cr.vhost(new_resource.vhost)
    end
  end

  def action_create
    create_exchange
  end

  private

  def create_exchange
    return if exchange.exists?

    Chef::Log.info "Creating RabbitMQ exchange '#{exchange.name}'."
    RabbitMQ.admin "declare exchange --user=#{exchange.user} --password='#{exchange.password}' --vhost=#{exchange.vhost} name=#{exchange.name} type=#{exchange.type}"
    new_resource.updated_by_last_action(true)
  end

  def exchange
    new_resource
  end
end
