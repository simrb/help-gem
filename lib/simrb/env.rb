
Sroot 	= Dir.pwd + '/'
Svalid 	= {}
Sdata 	= {}
Sload 	= {}

class Sl
	@@options = {}

	class << self
		def [] key
			key = key.to_s
			@@options.include?(key) ? @@options[key] : key
		end

		def << h
			@@options.merge!(h)
		end
	end
end

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
			args = args.class.to_s == 'Array' ? args.join("\n") : args.to_s
			puts "="*30 + "\n" + args + "\n" + "="*30
		end

		def load_module
			module_ds = {}
			Dir["#{Spath[:module]}*"].each do | path |
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
		# root path
		:module					=> Sroot + 'modules/',
		:public					=> Sroot + 'public/',
		:db_dir					=> Sroot + 'db/',
		:upload_dir				=> Sroot + 'db/upload/',
		:backup_dir				=> Sroot + 'db/backup/',
		:tmp_dir				=> Sroot + 'tmp/',
		:cache_dir				=> Sroot + 'tmp/cache/simrb/',
		:install_lock_file		=> Sroot + 'tmp/install.lock',
		:log_dir				=> Sroot + 'log/',
		:server_log				=> Sroot + 'log/thin.log',
		:command_log			=> Sroot + 'log/command_error_log.html',

		# sub path under the module directory
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
		:init_module_path		=> [:route, :store, :lang, :schema, :install, :modinfo, :misc, :gemfile, :view, :assets, :readme],
		:init_dir_path			=> [:db_dir, :upload_dir, :backup_dir, :tmp_dir, :log_dir, :module],
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
		:init_self				=> [:lang, :db_connection, :environment, :bind, :port],
	}

end

require 'sinatra'
require 'sequel'
require 'slim'

# increase data and valid block
module Sinatra
	class Application < Base
		def self.data name = '', &block
			(Sdata[name] ||= []) << block
		end
		def self.valid name = '', &block
			(Svalid[name] ||= []) << block
		end
	end

	module Delegator
		delegate :data, :valid
	end
end
