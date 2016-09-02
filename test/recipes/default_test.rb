# # encoding: utf-8

# Inspec test for recipe tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

#unless os.windows?
#  describe user('root') do
#    it { should exist }
#    skip 'This is an example test, replace with your own test.'
#  end
#end

#describe port(80) do
#  it { should_not be_listening }
#  skip 'This is an example test, replace with your own test.'
#end

describe command('curl http://localhost:8080/sample/index.html') do
  its(:stdout) {should match /Sample/ }
end

describe package('default-jdk') do
  it { should be_installed }
end

describe group('tomcat') do
  it { should exist }
end

describe user('tomcat') do
  it { should exist }
  it { should belong_to_group 'tomcat' }
  it { should have_home_directory '/opt/tomcat' }
end

#describe file('apache-tomcat-8.5.4.tar.gz') do
#  it { should exist }
#end

describe file('/opt/tomcat') do
  it { should exist }
  it { should be_directory }
end

describe file('/opt/tomcat/conf') do
  it { should be_directory }
  it { should be_mode 0070 }
end

%w[ work temp logs ].each do |path|
 describe file("/opt/tomcat/#{path}") do
   it { should exist}
   it { should be_owned_by 'tomcat'}
 end
end
