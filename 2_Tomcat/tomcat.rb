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

