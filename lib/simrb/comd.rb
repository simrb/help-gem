# 
# the file defines the base functionality of commands
# that let you initializing a project, create an empty directory of module, or get
# from remote repository, show the info of this software version, help document, and so on
#

module Simrb
	class Scommand

		# run the command
		#
		# == Example
		#
		# sapp = Simrb::Scommand.new
		# sapp.run ARGV
		#
		def run args = []
			cmd = args.empty? ? '' : args.shift
			if Scommand.private_method_defined? cmd
				self.send(cmd, args)
			elsif cmd == "help"
				require 'simrb/docs'
				Simrb.help args
			else
				puts "No command called #{cmd}, please try `$ simrb help`"
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

				# initialize the repositories
				Scfg[:repo_dirs].each do | path |
					Simrb.path_write "#{path}/"
				end

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

				puts "Initialized completely"
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
				puts "Starting to create module directories"

				args.each do | name |
					if Smods.keys.include? name
						puts "The module #{name} is existing, hasn't new it"
					else
						# create root dir of module
						Simrb.path_write "#{Spath[:module]}#{name}/"

						Dir.chdir "."

						# create sub dir of module 
						Scfg[:init_module_path].each do | item |
							path = "#{Spath[:module]}#{name}#{Spath[item]}"
							Simrb.path_write path
							Simrb.p({created: path}, :write)
						end

						# write the content of module info
						res = Scfg[:init_module_field].merge({'name' => name})
						path = "#{Spath[:module]}#{name}#{Spath[:modinfo]}"
						Simrb.yaml_write path, [res]
						Simrb.p({wrote: path}, :write)

						# write the content of .gitignore
						path = "#{Spath[:module]}#{name}#{Spath[:gitignore]}"
						File.open(path, "w+") do | f |
							f.write Scfg[:init_gitinore_item].join("\n")
						end
						Simrb.p({wrote: path}, :write)
					end
				end

				puts "Initializing module completed"
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

				repo_dir = "#{Spath[:repo_dirs][0]}/"
				Simrb.path_write repo_dir

				args.each do | all_name |
					name = all_name.split('/').last
					if Smods.keys.include? name
						puts "The module #{name} is existing at local repository, hasn't got from remote"
					else
						path	= "#{Scfg[:source]}#{all_name}.git"
						local	= "#{repo_dir}#{name}"
						system("git clone #{path} #{local}")
					end
				end

				puts "Implemented completely"
			end

			# pull whole remote repository from github
			#
			# == Example
			#
			# by default, that will pull the official repo
			#
			# 	$ simrb pull
			#
			# or, specify the link you need
			#
			# 	$ simrb pull demo/repo ~/simrb_repo
			#
			def pull args = []
				from_repo	= Scfg[:source] + (args[0] ? args[0] : "simrb/repo")
				to_repo		= args[1] ? args[1] : Spath[:repo_dirs][0]
				to_repo		= "#{to_repo}/" unless to_repo[-1] == '/'

				Simrb.path_write to_repo
				system("git clone #{from_repo}.git")
				system("mv #{from_repo.split('/').last} #{to_repo}")
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

	end
end

