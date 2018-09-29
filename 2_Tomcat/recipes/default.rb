#####Module 2: Tomcat###########
#run cmd:
##sudo chef-client --local-mode default.rb


case node['platform']
###INSTALL JDK1.7 for RHEL || CENTOS
when 'redhat', 'centos'
   yum_package 'java-1.7.0-openjdk-devel' do
		action :upgrade
   end
##INSTALL JDK1.8 FOR UBUNTU
when 'ubuntu'
   apt_update
   apt_package 'openjdk-7-jdk' do
		action :upgrade
	end
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
  not_if { File.exists?("/opt/tomcat/RELEASE-NOTES") }
end

#chmod -> change permissions (recursive permissions)
bash 'tomcat_config' do
  code <<-EOH
chgrp -R tomcat /opt/tomcat
chmod -R g+r /opt/tomcat/conf
chmod g+x /opt/tomcat/conf
chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
EOH
end

case node['platform']
#Install the Systemd Unit File + reload + start + enable FOR RHEL+CENTOS
when 'redhat', 'centos'
	systemd_unit 'tomcat.service' do
	  content({Unit: {
				Description:'Apache Tomcat Web Application Container',
				After:'syslog.target network.target',
			  },
			  Service: {
				Type:'forking',
				Environment:'JAVA_HOME=/usr/lib/jvm/jre',
				Environment:'CATALINA_PID=/opt/tomcat/temp/tomcat.pid',
				Environment:'CATALINA_HOME=/opt/tomcat',
				Environment:'CATALINA_BASE=/opt/tomcat',
				Environment:'CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC',
				Environment:'JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom',
				ExecStart:'/opt/tomcat/bin/startup.sh',
				ExecStop:'/bin/kill -15 $MAINPID',
				User:'tomcat',
				Group:'tomcat',
				UMask:'0007',
				RestartSec:10,
				Restart:'always',
			  },
			  Install: {
				WantedBy:'multi-user.target',
			  }})
	  action [:stop, :create, :reload, :start, :enable]
	end
#Install the Systemd Unit File + reload + start + enable FOR UBUNTU
when 'ubuntu'

#Using ubuntu 14.04, which isn't fully compatible with systemd 
#instructions from https://poweruphosting.com/blog/install-tomcat-8-ubuntu/
file 'etc/yum.repos.d/mongodb-org.repo' do
  content 'description "Tomcat Server"

start on runlevel [2345]
stop on runlevel [!2345]
respawn
respawn limit 10 5

setuid tomcat
setgid tomcat

env JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
env CATALINA_HOME=/opt/tomcat

# Modify these options as needed
env JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
env CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

exec $CATALINA_HOME/bin/catalina.sh run

# cleanup temp directory after stop
post-stop script
  rm -rf $CATALINA_HOME/temp/*
end script'
end				

service "tomcat" do
  action [:stop,:reload, :start, :enable]
end

end
