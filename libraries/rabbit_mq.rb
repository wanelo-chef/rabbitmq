module RabbitMQ
  def self.ctl(cmd, options = {})
    cmd = Mixlib::ShellOut.new("su - rabbitmq -c 'rabbitmqctl -q #{cmd}'", options)
    cmd.run_command
    cmd.error!
    cmd
  end

  def self.plugins(cmd, options = {})
    cmd = Mixlib::ShellOut.new("su - rabbitmq -c 'rabbitmq-plugins #{cmd}'", options)
    cmd.run_command
    cmd.error!
    cmd
  end

  def self.admin(cmd, options = {})
    cmd = Mixlib::ShellOut.new("su - rabbitmq -c 'rabbitmqadmin #{cmd}'", options)
    cmd.run_command
    cmd.error!
    cmd
  end
end
