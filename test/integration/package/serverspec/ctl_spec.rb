require 'spec_helper'

describe 'rabbitmqctl' do
  describe 'status' do
    it 'succeeds when run as rabbitmq' do
      %x(su - rabbitmq -c "rabbitmqctl status")
      expect($?.exitstatus).to eq(0)
    end
  end
end
