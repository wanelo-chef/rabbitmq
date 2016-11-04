module RabbitMQ
  # TODO: Make configurable
  DEFAULT_OPTIONS = { env: { 'HOME' => '/root' } }

  def self.ctl(cmd, options = {})
    cmd = Mixlib::ShellOut.new("su - rabbitmq -c 'rabbitmqctl -q #{cmd}'", DEFAULT_OPTIONS.merge(options))
    cmd.run_command
    cmd.error!
    cmd
  end

  def self.plugins(cmd, options = {})
    cmd = Mixlib::ShellOut.new("rabbitmq-plugins #{cmd}", DEFAULT_OPTIONS.merge(options))
    cmd.run_command
    cmd.error!
    cmd
  end

  def self.admin(cmd, options = {})
    cmd = Mixlib::ShellOut.new("rabbitmqadmin #{cmd}", DEFAULT_OPTIONS.merge(options))
    cmd.run_command
    cmd.error!
    cmd
  end
end
