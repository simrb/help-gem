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

		def p args
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

			puts "="*30 + "\n" + res + "\n" + "="*30
		end

		def load_module
			module_ds = {}
			Dir["#{Spath[:apps]}*"].each do | path |
				path 	= "#{path}#{Spath[:modinfo]}"
				content = Simrb.yaml_read path
				name	= content[0]["name"]
				order	= (content[0]["order"] || 99)
				module_ds[name] = order unless Scfg[:disable_modules].include?(name)
			end

			res 		= []
			module_ds	= module_ds.sort_by { |k, v| v }
			module_ds.each do | item |
				res << item[0]
			end
			res
		end

		def path_init path
			unless File.exist?(path)
				if path[-1] == '/'
					Dir.mkdir(path) 
				else
					File.open(path, 'w+') do | f |
						f.write("")
					end
				end
			end
		end

	end

	# basic path definition
	Spath						= {
		# root path of project
		:apps					=> 'apps/',
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
		:box					=> '/boxes/',
		:lang					=> '/boxes/langs/',
		:doc					=> '/boxes/docs/',
		:schema					=> '/boxes/migrations/',
		:install				=> '/boxes/installs/',
		:modinfo				=> '/boxes/installs/_mods',
		:vars					=> '/boxes/installs/_vars',
		:menu					=> '/boxes/installs/_menu',
		:tpl					=> '/boxes/tpls/',
		:layout_css				=> '/boxes/tpls/layout.css',
		:common_css				=> '/boxes/tpls/common.css',
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
		:field_alias			=> {int:'Fixnum', str:'String', text:'Text', time:'Time', big:'Bignum', fl:'Float'},
		:init_module_path		=> [:box, :lang, :schema, :install, :modinfo, :misc, :gemfile, :view, :assets, :readme, :route],
		:init_root_path			=> [:db_dir, :upload_dir, :backup_dir, :tmp_dir, :log_dir, :apps],
		:environment 			=> 'development',						# or production, test
		:main_module			=> 'system',
		:disable_modules		=> [],
		:encoding				=> 'utf-8',
		:lang					=> 'en',
		:install_lock			=> 'yes',
		:db_connection			=> 'sqlite://db/data.db',
		:server_log_mode		=> 'file',
		:repo_source			=> 'https://github.com/',
		:server 				=> 'thin',
		:bind 					=> '0.0.0.0',
		:port					=> 3000,
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

