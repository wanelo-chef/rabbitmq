module RabbitMQ
  def self.ctl(cmd, options = {})
    cmd = Mixlib::ShellOut.new("su - rabbitmq -c 'rabbitmqctl -q #{cmd}'", options)
    cmd.run_command
    cmd.error!
    cmd
  end

  def self.plugins(cmd, options = {})
    cmd = Mixlib::ShellOut.new("rabbitmq-plugins #{cmd}", options)
    cmd.run_command
    cmd.error!
    cmd
  end

  def self.admin(cmd, options = {})
    cmd = Mixlib::ShellOut.new("rabbitmqadmin #{cmd}", options)
    cmd.run_command
    cmd.error!
    cmd
  end
end
