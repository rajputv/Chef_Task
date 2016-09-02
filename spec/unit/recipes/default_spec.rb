#
# Cookbook Name:: tomcat
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'tomcat::default' do
  describe command('curl http://localhost:8080') do
    its(:stdout) {should match /Tomcat/ }
  end
  describe package('default-jdk') do
    it { should be_installed }
  end

end
