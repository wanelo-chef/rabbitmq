require 'spec_helper'
require 'chef'
require 'rabbitmq_plugin_provider'

describe Chef::Provider::RabbitmqPlugin do
  let(:node) { Chef::Node.new }
  let(:cookbook_collection) { double }
  let(:events) { Chef::EventDispatch::Dispatcher.new }
  let(:run_context) { Chef::RunContext.new(node, cookbook_collection, events) }
  let(:resource_name) { 'thing' }
  let(:resource) { Chef::Resource::RabbitmqPlugin.new(resource_name) }
  let(:provider) { Chef::Provider::RabbitmqPlugin.new(resource, run_context) }

  describe '#action_enable' do
    before do
      allow(RabbitMQ).to receive(:plugins)
      allow(resource).to receive(:updated_by_last_action)
    end

    context 'when provider is not enabled' do
      before { allow(resource).to receive(:enabled?).and_return(false) }

      it 'enables the plugin' do
        provider.action_enable
        expect(RabbitMQ).to have_received(:plugins).with('enable thing')
      end

      it 'sets the resource to be updated by the last action' do
        provider.action_enable
        expect(resource).to have_received(:updated_by_last_action).with(true)
      end
    end

    context 'when the provider is already enabled' do
      before { allow(resource).to receive(:enabled?).and_return(true) }

      it 'does not re-enable the plugin' do
        provider.action_enable
        expect(RabbitMQ).not_to have_received(:plugins)
      end

      it 'does not set the resource to be updated' do
        provider.action_enable
        expect(resource).not_to have_received(:updated_by_last_action)
      end
    end
  end

  describe '#action_disable' do
    before do
      allow(RabbitMQ).to receive(:plugins)
      allow(resource).to receive(:updated_by_last_action)
    end

    context 'when provider is not enabled' do
      before { allow(resource).to receive(:enabled?).and_return(false) }

      it 'does not re-disable the plugin' do
        provider.action_disable
        expect(RabbitMQ).not_to have_received(:plugins)
      end

      it 'does not set the resource to be updated' do
        provider.action_disable
        expect(resource).not_to have_received(:updated_by_last_action)
      end
    end

    context 'when the provider is enabled' do
      before { allow(resource).to receive(:enabled?).and_return(true) }

      it 'disables the plugin' do
        provider.action_disable
        expect(RabbitMQ).to have_received(:plugins).with('disable thing')
      end

      it 'sets the resource to be updated by the last action' do
        provider.action_disable
        expect(resource).to have_received(:updated_by_last_action).with(true)
      end
    end
  end
end
