require 'spec_helper'

describe 'rabbitmqctl' do
  describe 'status' do
    it 'succeeds when run as rabbitmq' do
      status = system('su - rabbitmq -c "rabbitmqctl status"')
      expect(status).to be true
    end
  end
end
