require 'simrb/info'

module Simrb

	class Scommand

		# generate a copy of simrb that clones from remote
		#
		# == Example
		# 
		# 	$ simrb init myapp
		#
		def self.init
			# get the copy from remote repository
			@appname = @args[0] ? @args[0] : 'simrb'
			system("git clone https://github.com/simrb/simrb.git #{@appname}")

			# initializes detected the running environment
			init_env
		end

		# initialize environment
		def self.init_env
			# basic gem bundling
			if @args.include? '--dev'
				system("bundle install --gemfile=#{@appname}/modules/system/stores/Gemfile --without=production")
			elsif @args.include? '--pro'
				system("bundle install --gemfile=#{@appname}/modules/system/stores/Gemfile --without=develpment")
			else

			end
		end

		def self.run argv
			if argv.count > 0
				@cmd 	= argv.shift
				@args	= argv ? argv : []
			end

			case @cmd
			when 'init'
				init
				puts "Successfully initialized"
			when 'kill'
				kill
				puts "the process of web server has been killed yet"
			else
				puts "No #{@cmd} command found in simrb"
			end
		end

		def self.kill
			s = `ps ax | grep 'ruby thin.rb'`
 			s = s.split("\n")[0].split(" ")[0]
			s = system("kill #{s}")
		end

	end

end

