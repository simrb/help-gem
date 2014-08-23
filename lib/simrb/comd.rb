# 
# the file defines the base functionality of commands
# that let you initializing a project, create an empty directory of module, or get
# from remote repository, show the info of this software version, help document, and so on
#

module Simrb
	class Scommand

		def run args = []
			cmd = args.empty? ? '' : args.shift
			if Scommand.private_method_defined? cmd
				self.send(cmd, args)
			elsif cmd == "help"
				help args
			else
				puts "No command called #{cmd}, please try ==> $ simrb help"
			end
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
			# details see the new and get method
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
					Simrb.path_write path
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
						name.index("/") ? get(args) : new(args)
					end
				end

				# initialize rubygem bundled
# 				mode = "develpment"
# 				if @args.include? '--dev'
# 					mode = "production"
# 				end
# 				system("bundle install --gemfile=#{@app_name}/apps/#{@module_name}#{@gemfile_path} --without=#{mode}")

				puts "Initialized project completion"
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
				Simrb.root_dir_force

				args.each do | name |
					if Smodules.keys.include? name
						puts "The module #{name} is existing, not new it"
					else
						# create root dir of module
						Simrb.path_write "#{Spath[:module]}#{name}/"

						Dir.chdir "."

						# create sub dir of module 
						Scfg[:init_module_path].each do | item |
							path = "#{Spath[:module]}#{name}#{Spath[item]}"
							Simrb.path_write path
						end

						# write the content of module info
						text = [{ 'name' => name, 'author' => 'unknown', 'version' => '1.0.0' }]
						Simrb.yaml_write "#{Spath[:module]}#{name}#{Spath[:modinfo]}", text

						# write the content of .gitignore
						path = "#{Spath[:module]}#{name}#{Spath[:gitignore]}"
						File.open(path, "w+") do | f |
							f.write "*.swp\n*.gem\n*~"
						end
					end
				end

				puts "Initialized module completion"
			end

			# get a module from remote repository to local
			# autually, this is a clone method of git
			#
			# == Example
			# 
			# 	$ simrb get simrb/system
			#
			# or, more than one at same time
			#
			# 	$ simrb get simrb/system simrb/test
			#
			def get args
				Simrb.root_dir_force
				Simrb.path_write(Spath[:repo_local]) unless File.exist?(Spath[:repo_local])

				args.each do | all_name |
					name = all_name.split('/').last
					if Smodules.keys.include? name
						puts "The module #{name} is existing at local repository, hasn't got from remote"
					else
						path	= "#{Scfg[:repo_remote]}#{all_name}.git"
						local	= "#{Spath[:repo_local]}#{name}"
						system("git clone #{path} #{local}")
					end
				end

				puts "Implemented completion"
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
				puts "Killed the process #{s} of Simrb"
			end

			# display the basic inforamtion of current version of Simrb
			#
			# == Example
			#
			# 	$ simrb info
			#
			def info args = []
				require 'simrb/info'
				Simrb.p Simrb::Info
			end

			# the help document
			#
			# == Example
			#
			# 	$ simrb help
			# 	$ simrb help 0
			#
			def help args = []
				require 'simrb/docs'

				res 		= []
				i 			= 0
				docs_key 	= {}
				docs_val 	= {}
				Sdocs.each do | key, val |
					docs_key[i] = key
					docs_val[i] = val
					i = i + 1
				end

				if args.empty?
					res << 'please select the number before the list to see detials'
					docs_key.each do | i, key |
						res << "#{i.to_s}, #{key}"
					end
				else
					args.each do | i |
						res << (docs_val.include?(i.to_i) ? docs_val[i.to_i] : 'no document')
					end
				end

				Simrb.p res
			end

	end
end

