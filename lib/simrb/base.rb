# 
# definition to the base methods, and default configuration options
# and the modules that would be loaded
#

Sroot = Dir.pwd + '/'

require "simrb/scfg"

module Simrb
	class << self

		def yaml_read path
			require 'yaml'
			YAML.load_file path
		rescue
			[]
		end

		def yaml_write path, data
			require "yaml"
			File.open(path, 'w+') do | f |
				f.write data.to_yaml
			end
		end

		def p args, action = nil
			res = ""

			if args.class.to_s == 'Array'
				res = args.join("\n")
			elsif args.class.to_s == 'Hash'
				args.each do | k, v |
					if action == :write
						res << "#{k.to_s.ljust(7)} -- #{v}\n"
					else
						res << "#{k.to_s.ljust(15)} => #{v}\n"
					end
				end
				res = res.chomp "\n"
			else
				res = args.to_s
			end

# 			puts "="*30 + "\n" + res + "\n" + "="*30
			puts res
			exit if action == :exit
		end

		# return an hash that stores the modules that consists of local directory and repository
		#
		# == Example
		#
		# 	Simrb.module_load
		#
		# assuming the :requrie_module option of Scfg file that is set as 'system', 
		# and two modules demo, demo2 in your local directory of project,
		# so, the result as below
		#
		# 	{
		# 		'system'	=>	'/your_repo_dir/system',
		# 		'demo'		=>	'/your_project_dir/modules/demo',
		# 		'demo2'		=>	'/your_project_dir/modules/demo2',
		# 	}
		#
		def module_load
			module_dirs = {}
			module_ds 	= {}

			# load modules from local repository
			Spath[:repo_dirs].map{|m| m + '*'}.each do | dir |
				Dir[dir].each do | path |
					name = path.split("/").last
					module_dirs[name] = File.expand_path(path) if Scfg[:module_require].include? name
				end
			end

			# load modules from project directory
			Dir["#{Spath[:module]}*"].each do | path |
				name = path.split("/").last
				module_dirs[name] = File.expand_path("#{Spath[:module]}#{name}") unless Scfg[:module_disable].include? name
			end

			# load the info of module
			module_dirs.each do | name, path |
				path 	= "#{path}#{Spath[:modinfo]}"
				res 	= Simrb.yaml_read path
				if res[0] and res[0]["name"] and res[0]["name"] == name
					module_ds[name] = (res[0]["order"] || 99)
				else
					Simrb.p "Loading error of module info, please check #{path}", :exit
				end
			end

			# sort module by order field of module
			res 		= {}
			module_ds	= module_ds.sort_by { |k, v| v }
			module_ds.each do | name, order |
				res[name] = module_dirs[name]
			end
			res
		end

		# initialize a path whatever it is a dir or file
		#
		# == Example
		#
		# new a file, or with the additional content
		#
		# 	path_write "myfile"
		# 	path_write "myfile", "file content"
		# 	path_write "myfile", "file content", "w+"
		#
		# create the dir
		#
		#	path_write "newdir/"
		#	path_write "newdir/newdir2/"
		#
		# create the dir and file at the same time
		#
		#	path_write "newdir/newdir2/myfile"
		#
		def path_write path, content = "", mode = "a+"
			if File.exist?(path)
				File.open(path, mode){|f| f.write content} unless path[-1] == '/'
			else
				arrs	= path.split('/')
				count	= arrs.count - 1
				(0..count).each do | i |
					new_path = arrs[0..i].join("/")
					unless File.exist? new_path
						new_path == path ? File.open(path, mode){|f| f.write content} : Dir.mkdir(new_path)
					end
				end
			end
		end

		def root_dir_force
			# check the required module is that existing
			Scfg[:module_require].each do | name |
				unless Smods.keys.include? name
					puts "Warning: the required module #{name} is not existing, wherever in local dir or repository"
				end
			end

			# check the file that is necessary to be loaded
			unless File.exist? 'scfg'
				Simrb.p "Current command only allow to be used under root directory of project", :exit
			end
		end

		# format the input argument from an array to two item, 
		# first item is orgin array, last is an hash option
		#
		# == Example
		#
		# 	args, opts = Simrb.input_format ["test", "test2", "--test", "--name=test2", "-n=test3"]
		#
		# the above is same as
		#
		# 	args, opts = Simrb.input_format ["--test", "test", "test2", "--name=test2", "-n=test3"]
		# 	
		# the options that starts with "-" you can write any positions of argument
		#
		# output
		#
		#	args = ["test", "test2"]
		#	opts = {test: true, name: test2, n:test3}
		# 	
		def input_format args = []
			resa = [] # return an array
			resh = {} # return an hash
			unless args.empty?
				args.each do | item |

					if item[0] == "-"
						new_item = item.split("-").uniq.last
						if new_item.index "="
							key, val = new_item.split "="
							resh[key.to_sym] = val
						else
							resh[new_item.to_sym] = true
						end
					else
						resa << item
					end

				end
			end
			[resa, resh]
		end

	end
end

# load config file in shortcut pipe
if File.exist? 'scfg'
	Simrb.yaml_read('scfg').each do | k, v |
		Scfg[k.to_sym] = v
	end
end

# load path in shortcut pipe
if File.exist? 'spath'
	Simrb.yaml_read('spath').each do | k, v |
		Spath[k.to_sym] = v
	end
end

# load modules
Smods = Simrb.module_load

