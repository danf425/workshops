# How to run (Runs on CentOS7 & Ubuntu 14.04):

* Clone the git repository: `git clone https://github.com/danf425/workshops.git`
* TomCat Module: From the '/workshops/' directory, run this cmd: `sudo chef-client --local-mode 2_Tomcat/recipes/default.rb`
* To test Tomcat, run cmd `curl http://localhost:8080`

Resources: 
* CentOS7 Installation: https://learn.chef.io/modules/learn-the-basics/rhel/virtualbox/set-up-a-machine-to-manage#/
* Ubuntu Installation: https://learn.chef.io/modules/learn-the-basics/ubuntu/virtualbox/set-up-a-machine-to-manage#/
* Chef-systemd_unit: https://docs.chef.io/resource_systemd_unit.html
* Chef-group: https://docs.chef.io/resource_group.html
* Chef-user: https://docs.chef.io/resource_user.html
* Chef-remote_file: https://docs.chef.io/resource_remote_file.html
* Chef-directory: https://docs.chef.io/resource_directory.html
* Chef-bash: https://docs.chef.io/resource_bash.html
* Chef-execute: https://docs.chef.io/resource_execute.html
* Chef-File: https://docs.chef.io/resource_file.html
* Chef-yum: https://docs.chef.io/resource_yum_package.html
* Chef-service: https://docs.chef.io/resource_service.html




















---------------------------------------------------------------------------------------------------------------------------------------
Initial Instructions Below
---------------------------------------------------------------------------------------------------------------------------------------





Install and Configure Apache Tomcat

The [Apache Tomcat®](http://tomcat.apache.org/) software is an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. The Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket specifications are developed under the Java Community Process.

## Goal

Use Chef to successfully install and configure tomcat on a RHEL7-based target system.

## Success Criteria

You should be prepared and able to demonstrate the following:

* Your Chef cookbook successfully executes on your target node without errors
* Your Chef cookbook is portable and can be run by Chef to validate your work. Please include any instructions or assumptions needed to successfully execute your cookbook.
* You can interact with the default tomcat site in a browser or successfully `curl localhost` on the target system
* You can run `chef-client` multiple times without failures
* Your GitHub.com source code repository shows the history of your work

You should be able to explain the following:

* Steps taken to achieve the end result
* Build and test process of Chef code
* Tools and resources used in the process

>Note: You are NOT required to use Chef Server for this exercise, but you may if that is your preference.

## Instructions

* Translate the Tomcat installation instructions from `INSTRUCTIONS.rb` into Chef code that completes the installation and configuration
* Use the Chef [Resources Reference](https://docs.chef.io/resources.html) to find the most appropriate Chef resources to use for each task
* Once you feel you have met the success criteria outlined above, send a link to your GitHub.com repo to the person coordinating these workshops on your behalf
* Provide instructions for us to run your cookbook so that we can test your work.

There are a couple of ways that you can write, test and run your cookbook.

* Write and test your cookbook locally using Test Kitchen via Vagrant + Virtual Box, or the cloud platform of your choice.
  * Steps for this option are outlined [here](https://learn.chef.io/tutorials/local-development/)
* Develop directly on your RHEL-based virtual machine
  * Write your cookbook in vim, nano or emacs, and run `chef-client` in `--local-mode`
  * The ChefDK or Chef Client must be installed on the VM first

## Suggested Resources

* Use the [Chef Documentation](http://docs.chef.io) to identify and use resources that will help you model the desired state of your infrastructure.
* [Tomcat Installation Instructions](https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-centos-7)
