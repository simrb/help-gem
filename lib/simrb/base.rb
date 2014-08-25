# 
# definition to the base methods, and default configuration options
# and the modules that would be loaded
#

Sroot = Dir.pwd + '/'
module Simrb

	# common methods
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

		def p args, out = nil
			res = ""

			if args.class.to_s == 'Array'
				res = args.join("\n")
			elsif args.class.to_s == 'Hash'
				args.each do | k, v |
					res << "#{k.to_s.ljust(15)} => #{v}\n"
				end
				res = res.chomp "\n"
			else
				res = args.to_s
			end

# 			puts "="*30 + "\n" + res + "\n" + "="*30
			puts res
			exit if out
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
			Dir["#{Spath[:repo_local]}*"].each do | path |
				name = path.split("/").last
				module_dirs[name] = File.expand_path("#{Spath[:repo_local]}#{name}") if Scfg[:require_modules].include? name
			end

			# load modules from project directory
			Dir["#{Spath[:module]}*"].each do | path |
				name = path.split("/").last
				module_dirs[name] = File.expand_path("#{Spath[:module]}#{name}") unless Scfg[:disable_modules].include? name
			end

			# check the required module that is existing ?
			Scfg[:require_modules].each do | name |
				unless module_dirs.include? name
					puts "Warning: the required module #{name} is not existing, wherever in local dir or repository"
				end
			end

			# load the info of module
			module_dirs.each do | name, path |
				path 	= "#{path}#{Spath[:modinfo]}"
				res 	= Simrb.yaml_read path
				if res[0]["name"] == name
					module_ds[name] = (res[0]["order"] || 99)
				else
					Simrb.p "Loading error to the module info, please check #{path}", :exit
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
				File.open(path, mode){|f| f.write content} if mode
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

	# basic path definition
	Spath						= {
		:repo_local				=> File.expand_path("~/.simrb/modules/"),

		# root path of project
		:module					=> 'modules/',
		:public					=> 'public/',
		:db_dir					=> 'db/',
		:upload_dir				=> 'db/upload/',
		:backup_dir				=> 'db/backup/',
		:tmp_dir				=> 'tmp/',
		:cache_dir				=> 'tmp/cache/simrb/',
		:install_lock_file		=> 'tmp/install.lock',
		:log_dir				=> 'log/',
		:server_log				=> 'log/thin.log',
		:command_log			=> 'log/command_error_log.html',

		# sub path under module directory of project
		:tool					=> '/tool/',
		:logic					=> '/logic/',
		:store					=> '/boxes/',
		:lang					=> '/boxes/langs/',
		:doc					=> '/boxes/docs/',
		:schema					=> '/boxes/migrations/',
		:install				=> '/boxes/installs/',
		:modinfo				=> '/boxes/installs/_mods',
		:tpl					=> '/boxes/tpls/',
		:misc					=> '/boxes/misc/',
		:gemfile				=> '/boxes/misc/Gemfile',
		:view					=> '/views/',
		:assets					=> '/views/assets/',
		:gitignore				=> '/.gitignore',
		:route					=> '/routes.rb',
		:readme					=> '/README.md',
	}

	# default settings of scfg file
	Scfg						= {
		:time_types				=> ['created', 'changed'],
		:fixnum_types			=> ['order', 'level'],
		:number_types 			=> ['Fixnum', 'Integer', 'Float'],

		:field_alias			=> {
			int:'Fixnum', str:'String', text:'Text',
			time:'Time', big:'Bignum', fl:'Float'
		},

		# options: development, production, test
		:environment 			=> 'development',

		# disable the modules of current project
		:disable_modules		=> [],

		# require the modules of local repository
		:require_modules		=> ["system"],

		:encoding				=> 'utf-8',
		:lang					=> 'en',
		:install_lock			=> 'yes',
		:db_connection			=> 'sqlite://db/data.db',
		:server_log_mode		=> 'file',
		:repo_remote			=> 'https://github.com/',
		:server 				=> 'thin',
		:bind 					=> '0.0.0.0',
		:port					=> 3000,

		:init_module_path		=> [
			:store, :lang, :schema, :install, :modinfo, :misc, 
			:gemfile, :view, :assets, :readme, :route
		],

		:init_root_path			=> [
			:db_dir, :upload_dir, :backup_dir, 
			:tmp_dir, :log_dir, :module, :repo_local
		],

		:init_module_field		=> { 'name' => 'unname', 'author' => 'unknown', 'version' => '1.0.0' },

		:init_gitinore_item		=> ["*.swp", "*.gem", "*~", "*.lock"],

		:init_scfg_item			=> [:lang, :db_connection, :environment, :bind, :port],
	}

end

# load config file in shortcut pipe
Scfg = Simrb::Scfg
if File.exist? 'scfg'
	Simrb.yaml_read('scfg').each do | k, v |
		Scfg[k.to_sym] = v
	end
end

# load path in shortcut pipe
Spath = Simrb::Spath
if File.exist? 'spath'
	Simrb.yaml_read('spath').each do | k, v |
		Spath[k.to_sym] = v
	end
end

# load modules
Smods = Simrb.module_load

