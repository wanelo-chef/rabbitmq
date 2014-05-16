require 'spec_helper'

describe user('rabbitmq') do
  it { should exist }
end
