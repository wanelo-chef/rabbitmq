require 'spec_helper'

describe 'rabbitmq_user lwrp' do
  it 'creates a user' do
    status = system('su - rabbitmq -c "rabbitmqctl -q list_users | grep my-user"')
    expect(status).to be true
  end
end
