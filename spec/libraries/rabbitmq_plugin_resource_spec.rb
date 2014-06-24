require 'spec_helper'
require 'rabbitmq_plugin_resource'

describe Chef::Resource::RabbitmqPlugin do
  let(:resource_name) { 'thing' }
  let(:resource) { Chef::Resource::RabbitmqPlugin.new(resource_name) }

  describe '#enabled?' do
    let(:plugins_list) { '' }
    let(:plugins_cmd) { double(stdout: plugins_list) }
    before do
      allow(RabbitMQ).to receive(:plugins).and_return(plugins_cmd)
    end

    context 'when there is an exact match' do
      let(:plugins_list) { "[e] thing 1.1.1\n" }

      it 'is true' do
        expect(resource.enabled?).to be true
      end
    end

    context 'when there is a partial match' do
      let(:plugins_list) { "[e] thing_of_stuff 1.1.1\n" }

      it 'is false' do
        expect(resource.enabled?).to be false
      end
    end

    context 'when there no match' do
      let(:plugins_list) { "\n" }

      it 'is false' do
        expect(resource.enabled?).to be false
      end
    end
  end
end
