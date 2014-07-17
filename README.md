# A framework to build server application

## BEGIN

How to install ?

	$ gem install simrb

or, install with github

	$ git clone https://github.com/simrb/simrb-gem.git
	$ cd simrb-gem
	$ ruby setup.rb

How to use ?

	$ simrb help

## RESCUE

If you are a newbie in ruby or web, the following options is that tells you how to setup the environment step by step. assuming you have new operating system that had not installed anything or configuration environment about application of `Simrb`

### Step 01, install ruby

	$ \curl -sSL https://get.rvm.io | bash -s stable
	# rvm install ruby-2.1.2

### Step 02, install git

	$ yum install git

### Step 03, install database, suppose the database is `sqlite`, type the commands to install it

	# yum install sqlite3*
	# yum install sqlite-devel

now, the string of database connection is `sqlite://db/data.db` that need to be fill in `scfg` file for using as an hash option, like `db_connection: sqlite://db/data.rb`

### Step 04, boot up by web server

about web server environment, check the port 80 and make sure it has not be used

	netstat -apn | grep :80

normally, you will find the apache(httpd) is running that always occupy the port 80, so remove it

	# yum remove httpd

add the port to iptable, then refresh the service

	# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
	# service iptables save
	# service iptables restart

and, if you need to change the port or ip of your project, just go to `scfg` file, modify the option `port: 80` or `bind: 0.0.0.0` as you want

## END
