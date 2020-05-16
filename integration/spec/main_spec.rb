require 'awspec'
require 'hcl/checker'

TFVARS = HCL::Checker.parse(File.open('testing.tfvars').read())

describe rds(TFVARS['db_name']) do
  it { should exist }
  it { should belong_to_db_subnet_group("#{TFVARS['db_name']}-rds-subnet-group") }
  it { should belong_to_vpc(TFVARS['vpc_id']) }
  its(:db_name) { should eq TFVARS['db_name'] }
  its(:allocated_storage) { should eq TFVARS['db_size'] }
  its(:storage_type) { should eq TFVARS['db_storage_type'] }
  its(:engine) { should eq TFVARS['db_engine'] }
  its(:engine_version) { should eq TFVARS['db_engine_version'] }
  its(:db_instance_class) { should eq TFVARS['db_instance_class'] }
  its(:master_username) { should eq TFVARS['db_username'] }
  it { should have_security_group("allow-#{TFVARS['db_name']}-access") }
  it { should have_security_group(TFVARS['allow_db_access_sgs'].first) }

  it 'should use the primary_db_subnets subnets' do
    subnets = subject.db_subnet_group.subnets.map {|subnet| subnet.subnet_identifier}

    expect(TFVARS['primary_db_subnets'] - subnets).to eq []
  end

  it 'should create the additional_db_subnet_config subnets' do
    subnets = subject.db_subnet_group.subnets.map {|subnet| subnet.subnet_identifier}
    subnets = subnets - TFVARS['primary_db_subnets']

    expect(subnets.size).to eq 2
  end
end

describe security_group("allow-#{TFVARS['db_name']}-access") do
  it { should have_tag('Name').value("Allow #{TFVARS['db_name']} Access") }
  its(:inbound) { should be_opened(TFVARS['db_port']).protocol('tcp').for(TFVARS['allow_db_access_sgs'][0]) }
  its(:outbound) { should be_opened(0).protocol('-1') }
end
