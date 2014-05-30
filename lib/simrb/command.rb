require 'simrb/info'

module Simrb

	class Scommand

		# pull the simrb
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
			# bash command
			if `which 3s`.empty?
				`echo 'alias 3s="ruby cmd.rb"' >> ~/.bashrc && source`
			end

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
			else
				puts "No #{@cmd} command found in simrb"
			end
		end

	end

end

