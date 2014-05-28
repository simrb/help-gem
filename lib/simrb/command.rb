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
			name = @args[0] ? @args[0] : 'simrb'
			`git clone https://github.com/simrb/simrb.git #{name}`

			# initializes detected the running environment
			init_env
		end

		# pull the module
		def self.init_env
			if `which 3s`.empty?
				`echo 'alias 3s="ruby cmd.rb"' >> ~/.bashrc && source`
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
			else
				puts "No #{@cmd} command found in simrb"
			end
		end

	end

end

