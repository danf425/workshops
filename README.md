
# Chef SA Workshops

Modules run on CentOS7 & Ubuntu 14.04

Recommended way of running modules (Requires Git): 
* Clone the git repository: `git clone https://github.com/danf425/workshops.git`
* MongoDB Module: From the '/workshops/' directory, run this cmd: `sudo chef-client --local-mode 1_MongoDB/recipes/default.rb`
  * Test with cmd: `mongo`
* Tomcat Module: From the '/workshops/' directory, run this cmd: `sudo chef-client --local-mode 2_Tomcat/recipes/default.rb`
  * Test with cmd: `curl http://localhost:8080`

Bonus:
* Module 1 & 2 are ubuntu 14.04 combatible
* Chefspec Test: From the '/workshops/' directory, run this cmd: `sudo chef exec rspec 1_MongoDB/spec/default_spec.rb`
* Middleman (Not finished): From the '/workshops/' directory, run this cmd `sudo chef-client --local-mode 3_Bonus/Middleman/recipes/default.rb`


Optional way of running it:
* Manually download/copy from `1_MongoDB/recipes/default.rb` & `2_Tomcat/recipes/default.rb`
* Paste them in your local CENTOS7/RHEL7 system
* Run them with the same cmd: `sudo chef-client --local-mode YOUR_FILE_NAME`


Resources: 
* Installing Git on CentOS7: `sudo yum install git`
* Installing Git on Ubuntu 14.04: `sudo apt-get install git-core`
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





----------------------------------------------------------------------------------------------------------------------------------------
Initial Instructions Below
----------------------------------------------------------------------------------------------------------------------------------------




Instructions

Complete the mandatory workshops below. These may be completed in any order, but it the recommendation is `1_MongoDB` then `2_Tomcat`.

* `1_MongoDB`
* `2_Tomcat`
* `3_Bonus`

Each workshop includes instructions stating the goal of the workshop, the success criteria, and, in some cases, basic instructions.  Basic instructions are provided with the understanding that those executing the workshops may not have any practical experience with the specific technologies involved.

If the first two workshops are completed successfully, additional bonus material from `3_Bonus` may be completed.  This is extra credit material and additional consideration will be given if it is attempted and/or completed successfully.

Expectations

There are no correct or incorrect working solutions to each of the workshops.  If the participant's solution meets the defined success criteria, that is a correct solution.  Each individual is expected to use their own experiences and approach to solving the task at hand.

* Work will be shown on github
  * Create a free account on [github.com](https://github.com) if you do not have one
  * Fork this repository
  * Commit your work locally and often to show progress
  * Do not forget to push to your github repo!
  * Provide instructions in your README.md for us to run your cookbook so that we can test your work.
  * Be prepared to explain your approach and thought process for building the cookbooks
  * Be prepared to present your working solutions by demonstrating successful `chef-client` runs

Projects Included

* **1_MongoDB:**  Install the software on the target system
* **2_Tomcat:**  Install and configure the Apache Tomcat Java application server on the target system
* **3_Bonus:**  Bonus Projects that can be completed in addition to `1_MongoDB` and `2_Tomcat`
  * Expand the functionality of the previous two workshops
    * Awesome Appliance Repair - A simple, python-based web application that utilizes Apache for a web server and MySQL for a database.
    * Middleman - A static site generator using all the shortcuts and tools in modern web development. It is a ruby (sinatra) application.

Pre-requisites

You will need some experience using Chef such as:

* Completing the exercises on [Learn Chef](http://learn.chef.io)
* Completing a Chef Essentials workshop or class
* Completing other online tutorials or training courses on Chef
* Real-world experience working with Chef

You will also need to install a few pieces of software on your local workstation:

* The [ChefDK](https://downloads.chef.io/chefdk) to develop and test your Chef code.
* A text editor to create and edit your Chef code (i.e. [Atom](https://atom.io), [VisualStudio Code](https://code.visualstudio.com), [SublimeText](https://www.sublimetext.com), or other)
* A free [GitHub.com](https://github.com) account to upload your work
* A virtual machine running a RHEL7 (or later) based linux distribution (RHEL, CentOS, Fedora, etc.) to serve as a test system
  * This can be a local or cloud-hosted VM
  >NOTE: Workshops in `3_Bonus` may require an Ubuntu-based operating system rather than RHEL7.  If required, it will be called out specifically within that workshop's README file.


## License & Authors

Author:: Nathen Harvey (<nharvey@getchef.com>)
Author:: Nicole Johnson (<nj@chef.io>)
Author:: Jeff Mery (<jmery@chef.io>)
Author:: Brian Chau (<brian@chef.io>)

Copyright:: 2017 Chef Software, Inc.

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).
