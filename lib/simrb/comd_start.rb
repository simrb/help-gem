module Simrb

	class Scommand

		@repos_path 	= "https://github.com/simrb/simrb.git"

		@gemfile_path 	= "/boxes/misc/Gemfile"

		@app_name		= "simrb"

		@module_name 	= "system"

		# generate a copy of simrb that clones from remote
		#
		# == Example
		# 
		# 	$ simrb init myapp
		#
		def self.init
			# get the copy from remote repository
			@app_name = @args[0] if @args[0]
			system("git clone #{@repos_path} #{@app_name}")

			# initializes detected the running environment
			init_env
		end

		# initialize environment
		def self.init_env
			# run gem bundle
			mode = "develpment"
			if @args.include? '--dev'
				mode = "production"
			end
			system("bundle install --gemfile=#{@app_name}/modules/#{@module_name}#{@gemfile_path} --without=#{mode}")
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
				puts "The process of web server has been killed yet"
			when 'info'
				info
			when 'clone'
				clone
				puts "The process of web server has been killed yet"
			else
				puts "No #{@cmd} command found"
			end
		end

		def self.kill
			s = `ps ax | grep 'ruby thin.rb'`
 			s = s.split("\n")[0].split(" ")[0]
			s = system("kill #{s}")
		end

		def self.clone
		end

		def self.info
			require 'simrb/info'
			puts Simrb::Info
		end

	end

end

