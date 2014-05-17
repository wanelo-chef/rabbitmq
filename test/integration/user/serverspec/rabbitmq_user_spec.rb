require 'spec_helper'

describe 'rabbitmq_user lwrp' do
  it 'creates a user' do
    status = system('su - rabbitmq -c "rabbitmqctl -q list_users | grep my-user"')
    expect(status).to be true
  end

  it 'does not fail when creating a preexisting user' do
    status = system('su - rabbitmq -c "rabbitmqctl -q list_users | grep preexisting_user"')
    expect(status).to be true
  end

  it 'sets permissions on users' do
    permissions = `su - rabbitmq -c "rabbitmqctl -q list_permissions -p /thing | grep user_with_permissions"`
    expect(permissions).to match(/user_with_permissions\s+\.\*\s+\.\*\s+\.\*/)
  end
end
