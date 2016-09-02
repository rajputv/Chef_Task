#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Installing Java default-jdk
package 'default-jdk'

# Create a tomcat group
group 'tomcat'

# Create a tomcat user
user 'tomcat' do
  shell '/bin/false'
  group 'tomcat'
  home '/opt/tomcat'
end

#wget tomcat
remote_file 'apache-tomcat-8.5.4.tar.gz' do
  source 'http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.tar.gz'
end

directory '/opt/tomcat' do
  #action :create
  group 'tomcat'
end

execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

execute 'chgrp -R tomcat /opt/tomcat/conf'

directory '/opt/tomcat/conf' do
  mode '0070'
end

execute 'chmod g+r /opt/tomcat/conf/*'

execute 'chown -R tomcat /opt/tomcat/work /opt/tomcat/temp /opt/tomcat/logs'

template '/etc/init/tomcat.conf' do
  source 'tomcat.conf.erb'
end

remote_file '/opt/tomcat/webapps/sample.war' do
  mode '0644'
  source 'https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war'
end

execute '/opt/tomcat/bin/startup.sh'
#execute 'initctl reload-configuration'

#execute 'initctl start tomcat'

#service 'tomcat' do
#  action [:start]
#end
