# A framework to build server application

## BEGIN

How to install ?

	$ gem install simrb

or, install with github

	$ git clone https://github.com/simrb/help-gem.git
	$ cd help-gem
	$ ruby setup.rb

How to use ?

	$ simrb help

## RESCUE

If you are a newbie in programming development, the following representation that tells you how to setup the environment step by step. assuming you have pure environment in your operating system that has not been installed anything or configured the application of `Simrb`

### Step 01, install ruby

	$ \curl -sSL https://get.rvm.io | bash -s stable
	# rvm install ruby-2.1.3

### Step 02, install git

	$ yum install git

### Step 03, install database, we suppose you use the database `sqlite` as the first installation, so

	# yum install sqlite3*
	# yum install sqlite-devel

now, the database connection string that supposes to be `db_connection: sqlite://db/data.rb`, you would place it in `scfg.rb` file later

### Step 04, booting

about web server environment, check the port 80 and make sure it has not been used

	netstat -apn | grep :80

normally, you will find the apache(httpd) is running that always occupy the port 80, so remove it

	# yum remove httpd

add the port to iptable, then refresh the service

	# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
	# service iptables save
	# service iptables restart

finally, start it by web mode

	$ simrb start

### Edit server config

if you need to change the port or ip for your project, just modify the option `port: 80` or `bind: 0.0.0.0` of the `scfg.rb` file

### Kill server process

	ps -ax | grep 'simrb start'

## END
