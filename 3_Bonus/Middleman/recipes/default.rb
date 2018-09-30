
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

directory '~/ruby' do
  action :create
end

remote_file '~/ruby/ruby-2.1.3.tar.gz' do
    source 'http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz'
    notifies :run, "bash[install_ruby]", :immediately
end


bash "install_ruby" do
  code <<-EOH
tar -xzf ~/ruby/ruby-2.1.3.tar.gz
(cd ~/ruby/ruby-2.1.3 && ./configure && make install && rm -rf ~/ruby)
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
  ServerName <%= node['ipaddress'] %>
  ServerAlias <%= node['ipaddress'] %>

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
rm /etc/apache2/sites-enabled/000-default.conf
EOH
end

#restart apache
service 'apache2' do
  action :restart
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

bash "Clone the repo" do
  code <<-EOH
  git clone https://github.com/learnchef/middleman-blog.git
  cd middleman-blog
  EOH
end



end

