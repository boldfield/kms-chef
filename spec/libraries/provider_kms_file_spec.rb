require_relative '../spec_helper'
require_relative '../../libraries/provider_kms_file'

describe Chef::Resource::KmsFile do
  let(:name) { 'default' }
  let(:run_context) { ChefSpec::SoloRunner.new.converge.run_context }
  let(:resource) { described_class.new(name, run_context) }

  describe '#initialize' do
    it 'sets the correct resource name' do
      expect(resource.resource_name).to eq(:kms_file)
    end

    it 'sets the correct supported actions' do
      expected = [:create, :delete]
      expect(resource.allowed_actions).to eq(expected)
    end

    it 'sets the correct default action' do
      expect(resource.action).to eq([:create])
    end

    it 'sets the created status to false' do
      expect(resource.created).to eq(false)
    end

    it 'sets the created? status to false' do
      expect(resource.created?).to eq(false)
    end
  end
end
