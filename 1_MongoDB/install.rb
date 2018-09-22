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


# Create a /etc/yum.repos.d/mongodb.repo file to hold the following configuration information for the MongoDB repository:
file 'etc/yum.repos.d/mongodb-org.repo' do
  content '[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/i686/
gpgcheck=0
enabled=1'
end

# Install the MongoDB packages and associated tools.
yum_package 'mongodb-org' do
  action :upgrade
end

# Start MongoDB + ensure that MongoDB will start following a system reboot
service 'mongod' do
  action [:enable,:start]
end

