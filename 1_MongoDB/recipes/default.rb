##########################################################################
# Cookbook Name:: mongodb
# Recipe:: install
#
# Not sure how to get started?
#
# You could:
# 1.  copy the relevant commands from http://docs.mongodb.org/manual/tutorial/install-mongodb-on-red-hat-centos-or-fedora-linux/
# 2.  comment out everything
# 3.  add the Chef resources and other Chef code necessary
#
# This file is an example of steps 1 and 2 above.
##########################################################################

#run cmd:
##sudo chef-client --local-mode default.rb

case node['platform']
###INSTALLATION/SETUP FOR RHEL
when 'redhat', 'centos'

# Create a /etc/yum.repos.d/mongodb.repo file to hold the following configuration information for the MongoDB repository:
file 'etc/yum.repos.d/mongodb-org.repo' do
  content '[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1'
end

# Install the MongoDB packages and associated tools.
yum_package 'mongodb-org' do
  action :upgrade
end

##INSTALLATION/SETUP FOR UBUNTU
when 'ubuntu'
###UBUNTU-14.04-TRUSTY
bash 'Public_key+source_list' do
  code <<-EOH
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
apt-get update
EOH
not_if { File.exists?("/etc/apt/sources.list.d/mongodb-org-3.0.list") }
end

apt_package "mongodb-org" do
  action :upgrade
end

end

case node['platform']
when 'redhat','centos','ubuntu'
# Start MongoDB + ensure that MongoDB will start following a system reboot
service 'mongod' do
  action [:enable,:start]
end
end



#Resources used: 
#1)https://learn.chef.io/modules/learn-the-basics/rhel/virtualbox/set-up-a-machine-to-manage#/
#   CentOS7 + Vagrant + VirtualBox + ChefSDK + Vim
#2)https://docs.chef.io/resource_reference.html
#3)https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
#4) http://docs.mongodb.org/manual/tutorial/install-mongodb-on-red-hat-centos-or-fedora-linux/

