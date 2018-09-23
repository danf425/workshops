# frozen_string_literal: true
require 'chefspec'


describe '1_MongoDB::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs mongodb-org' do
    expect(chef_run).to upgrade_yum_package('mongodb-org')
  end
end
