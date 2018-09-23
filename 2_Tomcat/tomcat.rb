#####Module 2: Tomcat###########

#install JDK1.7
yum_package 'java-1.7.0-openjdk-devel' do
   action :upgrade
end

#Create a user for tomcat
group 'tomcat' do
   action :create
end

user 'tomcat' do
   action :create
   gid 'tomcat'
   home '/opt/tomcat'
   shell '/bin/nologin'
end

#Download the Tomcat Binary
remote_file '/tmp/apache-tomcat-8.5.9.tar.gz' do
    source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz'
end

#sudo mkdir /opt/tomcat
directory '/opt/tomcat' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#extract tar file
execute '/tmp/apache-tomcat-8.5.9.tar.gz' do
  command 'tar -xzvf /tmp/apache-tomcat-8.5.9.tar.gz '\
    '--strip-components=1'
  cwd '/opt/tomcat'
end

#chmod
bash 'tomcat_config' do
  code <<-EOH
chgrp -R tomcat /opt/tomcat
chmod -R g+r /opt/tomcat/conf
chmod g+x /opt/tomcat/conf
chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
EOH
end
