## INTRODUCTION

Managing the projects and applications of sinatra, it let you build the web application easily


## ENVIRONMENT

	ruby 2.1.3 +
	git 1.7.1 +


## INSTALLATION

	$ gem install simrb

or, install with github

	$ git clone https://github.com/simrb/help-gem.git
	$ cd help-gem
	$ ruby setup.rb

test it with making a look

	$ simrb help


## RESCUE for INSTALLTION

Deploying a web application is not easy due to the complex server environment, the below question maybe help you across these issues.


### How to setup the required environment

install ruby

	$ \curl -sSL https://get.rvm.io | bash -s stable
	# rvm install ruby-2.1.3

install git

	$ yum install git


### How to connect the database

assuming your database is `sqlite`, so

	# yum install sqlite3*
	# yum install sqlite-devel

by default, the ORM is sequel, and the db connection should be `db_connection: sqlite://db/data.rb`, you put it into `scfg.rb` file for using, more details see [Sequel](http://sequel.jeremyevans.net/rdoc/files/doc/opening_databases_rdoc.html)


### How to deal with the server

firstly, you should ensure your port like `:80` that has not been used

	netstat -apn | grep :80

normally, you will find the apache(httpd) is running, it always occupies the port 80, uninstall it

	# yum remove httpd

add the port to iptable, then refresh the service

	# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
	# service iptables save
	# service iptables restart

finally, start it by web mode

	$ simrb start

stop the server in production mode of running environment

	$ simrb kill

if it failed, kill its process for stop

	ps -ax | grep 'simrb start'

find that process of including the 'simrb start' words

	kill -9 process_id


### How to configure the server settings

if you need to change the port or ip for your project, just modify the option `port: 80` or `bind: 0.0.0.0` in `scfg.rb` file

