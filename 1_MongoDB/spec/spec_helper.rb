# frozen_string_literal: true
require 'chefspec'
require 'chefspec/berkshelf'

describe '1_MongoDB::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'creates repo file' do
    expect(chef_run).to create_file('etc/yum.repos.d/mongodb-org.repo')
  end
end



