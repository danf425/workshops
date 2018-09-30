
# Cookbook:: Middleman
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


case node['platform']
when 'ubuntu'

# Update apt-get
apt_update

# Build Ruby
package %w(build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev nodejs libsqlite3-dev sqlite3) do
    action :upgrade
end


bash "install_ruby" do
  code <<-EOH
mkdir home/ruby
cd home/ruby
wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz
tar -xzf ruby-2.1.3.tar.gz
cd ruby-2.1.3
./configure
make install
rm -rf home/ruby
EOH
end

# Ruby may install to /usr/local/bin
#
# So you may need to make copies of the core commands into /usr/bin
# cp /usr/local/bin/ruby /usr/bin/ruby
# cp /usr/local/bin/gem /usr/bin/gem

# Install apache
apt_package 'apache2' do
    action :install
end


#create blog.conf for apache
file '/tmp/blog.conf' do
  content "# /etc/apache2/sites-enabled/blog.conf

LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so

ProxyRequests Off

<Proxy *>
  Order deny,allow
  Allow from all
</Proxy>


<VirtualHost *:80>
  ServerName test.localhost
  ServerAlias test.localhost

  ProxyRequests Off
  RewriteEngine On
  ProxyPreserveHost On
  ProxyPass / http://localhost:3000/
  ProxyPassReverse / http://localhost:3000/

</VirtualHost>"
end

#Configure apache
bash "configure_apache" do
  code <<-EOH
a2enmod proxy_http
a2enmod rewrite
cp /tmp/blog.conf /etc/apache2/sites-enabled/blog.conf
rm /etc/apache2/sites-enabled/000-default.conf || true
EOH
end

#restart apache
service 'apache2' do
  action [:reload, :restart]
end

#Git should already be installed, but upgrade
apt_package 'git' do
    action :upgrade
end


#clone git repo
# git "#{Chef::Config[:file_cache_path]}/ruby-build" do
#  repository https://github.com/learnchef/middleman-blog.git
#  action :sync
#end

bash "clone-repo+bundler+thin" do
  code <<-EOH
git clone https://github.com/learnchef/middleman-blog.git
cd middleman-blog
gem install bundler
bundle install
thin install
/usr/sbin/update-rc.d -f thin defaults
EOH
end

#Fix thin/blog.conf
file '/etc/thin/blog.yml' do
  content "# /etc/thin/blog.yml
pid: tmp/pids/thin.pid
log: log/thin.log
timeout: 30
max_conns: 102
port: 3000
max_persistent_conns: 512
chdir: /home/blog
environment: development
servers: 1
address: 0.0.0.0
daemonize: true"
end

#Fix /etc/apache2/sites-enabled/blog.conf
file '/etc/apache2/sites-enabled/blog.conf' do
  content "# /etc/init.d/thin

#!/bin/sh
### BEGIN INIT INFO
# Provides:          thin
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      S 0 1 6
# Short-Description: thin initscript
# Description:       thin
### END INIT INFO

# Original author: Forrest Robertson

# Do NOT "set -e"

DAEMON=/usr/local/bin/thin
SCRIPT_NAME=/etc/init.d/thin
CONFIG_PATH=/etc/thin
HOME= /home/blog

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

case "$1" in
  start)
  HOME=$HOME $DAEMON start --all $CONFIG_PATH
  ;;
  stop)
  HOME=$HOME $DAEMON stop --all $CONFIG_PATH
  ;;
  restart)
  HOME=$HOME $DAEMON restart --all $CONFIG_PATH
  ;;
  *)
  echo "Usage: $SCRIPT_NAME {start|stop|restart}" >&2
  exit 3
  ;;
esac

:"
end

#start thin
service 'thin' do
  action [:reload, :restart]
end

end

