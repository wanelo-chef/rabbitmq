
require 'spec_helper'

describe 'rabbitmq_vhost lwrp' do
  it 'creates a virtual host' do
    status = system('su - rabbitmq -c "rabbitmqctl -q list_vhosts | grep \'/thing\'"')
    expect(status).to be true
  end
end
