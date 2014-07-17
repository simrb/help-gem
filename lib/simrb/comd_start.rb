require 'simrb/config'

module Simrb

	class Scommand

		def run args = []
			@output = []
			cmd 	= args.empty? ? '' : args.shift
			if Scommand.private_method_defined? cmd
				self.send(cmd, args)
			else
				@output << ">> WARNING: No #{cmd} command found >>"
				help
			end
			Simrb.p(@output.empty? ? 'Implemented complete' : @output)
		end

		private

			# initialize a project directory
			#
			# == Example
			# 
			# 	$ simrb init myapp
			#
			# or, initialize directory and module at the same time with more arguments,
			# the simrb/system is from remote, the blog is generated by local,
			# details see the new and clone method
			#
			# 	$ simrb init myapp simrb/system blog
			#
			def init args
				app_name = args.empty? ? 'myapp' : args.shift 

				# generate module directories and files
				Dir.mkdir app_name
				Dir.chdir app_name

				Scfg[:init_root_path].each do | item |
					path = "#{Spath[item]}"
					Simrb::path_init path
				end

				# initialize scfg file
				data = {}
				Scfg[:init_scfg_item].each do | item |
					data[item] = Scfg[item]
				end
				Simrb.yaml_write('scfg', data)

				# create module if it is given,
				# get module from remote repository if it has the backslash,
				# other is created at local
				unless args.empty?
					args.each do | name |
						name.index("/") ? clone(args) : new(args)
					end
				end

				# initialize rubygem bundled
# 				mode = "develpment"
# 				if @args.include? '--dev'
# 					mode = "production"
# 				end
# 				system("bundle install --gemfile=#{@app_name}/apps/#{@module_name}#{@gemfile_path} --without=#{mode}")

				@output << "Initialized project complete"
			end

			# create a module, initialize default paths of file and directory
			#
			# == Example
			# 
			# 	$ simrb new blog
			#
			# or, more than one at same time
			# 	
			# 	$ simrb new blog cms test
			#
			def new args
				Simrb.is_root_dir?

				args.each do | name |
					if Sapps.include? name
						@output << "The module #{name} is existing, not new it"
					else
						# create root dir of module
						Simrb::path_init "#{Spath[:apps]}#{name}/"

						Dir.chdir "."

						# create sub dir of module 
						Scfg[:init_module_path].each do | item |
							path = "#{Spath[:apps]}#{name}#{Spath[item]}"
							Simrb::path_init path
						end

						# write the content of module info
						text = [{ 'name' => name }]
						Simrb.yaml_write "#{Spath[:apps]}#{name}#{Spath[:modinfo]}", text

						# write the content of .gitignore
						path = "#{Spath[:apps]}#{name}#{Spath[:gitignore]}"
						File.open(path, "w+") do | f |
							f.write "*.swp\n*.gem\n*~"
						end
					end
				end

				@output << "Initialized module complete"
			end

			# clone a module from remote repository to local
			#
			# == Example
			# 
			# 	$ simrb clone simrb/system
			#
			# or, more than one at same time
			#
			# 	$ simrb clone simrb/system simrb/test
			#
			def clone args
				Simrb.is_root_dir?

				args.each do | name |
					if Sapps.include? name
						@output << "The module #{name} is existing, not clone from remote"
					else
						path = "#{Scfg[:repo_source]}#{name[0]}.git"
						name = "#{Spath[:apps]}#{name[0].split('/').last}"
						system("git clone #{path} #{name}")
					end
				end

				@output << "Cloned module complete"
			end

			# kill the current process of Simrb of that is running in background
			#
			# == Example
			#
			# 	$ simrb kill
			#
			def kill args = []
				s = `ps -ax | grep 'simrb start'`
				s = s.split("\n")[0].split(" ")[0]
# 				s = `cat #{Spath[:tmp_dir]}pid`.split("\n")[0]
# 				`rm #{Spath[:tmp_dir]}pid`

				system("kill #{s}")
				@output << "Killed the process #{s} of Simrb"
			end

			# display the basic inforamtion of current version of Simrb
			#
			# == Example
			#
			# 	$ simrb info
			#
			def info args = []
				require 'simrb/info'
				@output << Simrb::Info
			end

			# the help document
			#
			# == Example
			#
			# 	$ simrb help
			#
			def help args = []
				require 'simrb/docs'
				require 'simrb/help'
				@output << Simrb.docs(args)
			end

	end

end

simrb_app = Simrb::Scommand.new
simrb_app.run ARGV
