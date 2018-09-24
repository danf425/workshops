# frozen_string_literal: true
require 'chefspec'


describe '1_MongoDB::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '7.5.1804')
                          .converge(described_recipe)
  end

  it 'creates a file for mongodb' do
      expect(chef_run).to create_file('etc/yum.repos.d/mongodb-org.repo')
  end

  it 'installs a yum_package mongodb-org' do
#     expect(chef_run).to install_yum_package('mongodb-org')
      expect(chef_run).to upgrade_yum_package('mongodb-org')
  end

  it 'starts and enables mongod service' do
      expect(chef_run).to enable_service('mongod')
      expect(chef_run).to start_service('mongod')
#####      expect(chef_run).to stop_service('mongod') 
  end
end

