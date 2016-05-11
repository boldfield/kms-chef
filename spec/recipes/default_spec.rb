require_relative '../spec_helper'

describe 'kms::default' do
  let(:platform) { nil }
  let(:runner) { ChefSpec::SoloRunner.new(platform) }
  let(:chef_run) { runner.converge(described_recipe) }

  context 'Mac OS X platform' do
    let(:platform) { { platform: 'mac_os_x', version: '10.10' } }

    it 'installs aws-sdk-resources chef_gem' do
      expect(chef_run).to install_chef_gem('aws-sdk-resources').at_compile_time
    end

    it 'installs aws-sdk-core chef_gem' do
      expect(chef_run).to install_chef_gem('aws-sdk-core').at_compile_time
    end
  end
end
