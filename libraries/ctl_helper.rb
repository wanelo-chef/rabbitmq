module RabbitMQ
  def self.ctl(cmd, options = {})
    cmd = Mixlib::ShellOut.new("su - rabbitmq -c 'rabbitmqctl -q #{cmd}'", options)
    cmd.run_command
    cmd.error!
    cmd
  end
end