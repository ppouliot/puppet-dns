require 'spec_helper'

describe 'Dns::Acl', type: :define do
  let(:title) { 'trusted' }
  # let(:pre_condition) { 'include dns::server::params' }
  let :facts do
    {
      concat_basedir: '/tmp',
      osfamily: 'Debian',
    }
  end

  context 'passing a string to data' do
    let :params do
      {
        data: '192.168.0.0/24',
      }
    end

    # it { is_expected.to raise_error(Puppet::Error, /is not an Array/) }
    it { is_expected.to raise_error(Puppet::Error, %r{expects an Array}) }
  end
  context 'passing an array to data' do
    let :params do
      {
        data: ['192.168.0.0/24'],
      }
    end

    it { is_expected.not_to raise_error }
    it {
      is_expected.to contain_concat__fragment('named.conf.local.acl.trusted.include')
        .with_content(%r{acl trusted})
        .with_content(%r{192.168.0.0/24;})
    }
  end
end