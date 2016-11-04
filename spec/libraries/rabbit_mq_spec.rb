require 'spec_helper'
require 'rabbit_mq'

describe RabbitMQ do
  let(:defaults) { RabbitMQ::DEFAULT_OPTIONS }
  let(:shellout) { double(run_command: true, error!: true) }

  before do
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
  end

  describe '::ctl' do
    it 'shells out to rabbitmqctl as the rabbitmq user' do
      cmd = 'stuff with things'
      RabbitMQ.ctl(cmd)
      expect(Mixlib::ShellOut).to have_received(:new).with("su - rabbitmq -c 'rabbitmqctl -q #{cmd}'", {})
    end
  end

  describe '::plugins' do
    it 'shells out to rabbitmq-plugins' do
      cmd = 'stuff with things'
      RabbitMQ.plugins(cmd)
      expect(Mixlib::ShellOut).to have_received(:new).with("su - rabbitmq -c 'rabbitmq-plugins #{cmd}'", {})
    end
  end

  describe '::admin' do
    it 'shells out to rabbitmqadmin' do
      cmd = 'check some stuff'
      RabbitMQ.admin(cmd)
      expect(Mixlib::ShellOut).to have_received(:new).with("su - rabbitmq -c 'rabbitmqadmin #{cmd}'", {})
    end
  end
end
