require 'spec_helper'
require 'etc'

describe 'rabbitmq_plugin lwrp' do
  describe 'enabled_plugins file' do
    let(:enabled_plugins_file) { '/opt/local/bin/rabbitmq/enabled_plugins' }

    it 'is created' do
      expect(File.directory?(enabled_plugins_dir)).to be true
    end

    it 'is owned by root' do
      uid = File.stat(enabled_plugins_dir).uid
      expect(Etc.getpwuid(uid).name).to eq('root')
    end
  end
end
