require 'spec_helper'

describe 'role fluentd' do
  describe yumrepo('treasuredata') do
    it { should exist }
  end
  describe package('td-agent') do
    it { should be_installed }
  end
  property['fluentd_plugins'].each do |plugin|
    describe command('/usr/sbin/td-agent-gem list --local') do
      its(:stdout) { should contain plugin }
    end
  end
  describe service('td-agent') do
    it { should be_enabled }
    it { should be_running }
  end
end
