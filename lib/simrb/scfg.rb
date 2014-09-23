
# basic path definition
Spath						= {
	:repo_dirs				=> [File.expand_path("~/.simrb/modules/")],

	# root path of project
	:module					=> 'modules/',
	:public					=> 'public/',
	:db_dir					=> 'db/',
	:upload_dir				=> 'db/upload/',
	:backup_dir				=> 'db/backup/',
	:tmp_dir				=> 'tmp/',
	:cache_dir				=> 'tmp/cache/simrb/',
	:install_lock			=> 'tmp/install.lock',
	:log_dir				=> 'log/',
	:server_log				=> 'log/thin.log',
	:command_log			=> 'log/command_error_log.html',
	:schema					=> 'log/migrations/',

	# sub path under module directory of project
	:tool					=> '/tool/',
	:logic					=> '/logic/',
	:store					=> '/store/',
	:lang					=> '/store/langs/',
	:doc					=> '/store/docs/',
	:install				=> '/store/installs/',
	:modinfo				=> '/store/installs/base_info',
	:tpl					=> '/store/tpls/',
	:misc					=> '/store/misc/',
	:gemfile				=> '/store/misc/Gemfile',
	:view					=> '/views/',
	:assets					=> '/views/assets/',
	:gitignore				=> '/.gitignore',
	:route					=> '/routes.rb',
	:readme					=> '/README.md',
}

# default settings of scfg file
Scfg						= {

	# disable the modules of current project
	:module_disable			=> [],

	# require the modules of local repository
	:module_require			=> [],

	:module_focus			=> nil,

	:user 					=> 'unknown',

	:encoding				=> 'utf-8',
	:lang					=> 'en',
	:install_lock			=> 'yes',
	:db_connection			=> 'sqlite://db/data.db',
	:server 				=> 'thin',
	:bind 					=> '0.0.0.0',
	:port					=> 3000,

	:source					=> 'https://github.com/',

	# options: development, production, test
	:environment 			=> 'development',

	:server_log_mode		=> 'file',

	:field_time				=> ['created', 'changed'],
	:field_fixnum			=> ['order', 'level'],
	:field_number 			=> ['Fixnum', 'Integer', 'Float'],

	:alias_fields			=> {
		int:'Fixnum', str:'String', text:'Text',
		time:'Time', big:'Bignum', fl:'Float'
	},

	# command alias name of generating methods
	:alias_gcmd				=> {
		'm' => 'migration', 'i' => 'install', 'd' => 'data', 'v' => 'view'
	},

	:alias_cmd				=> {
	},

	:init_module_path		=> [
		:store, :install, :modinfo, :misc, 
		:gemfile, :view, :assets, :readme, :route
	],

	:init_root_path			=> [
		:db_dir, :upload_dir, :backup_dir,
		:tmp_dir, :log_dir, :module, :schema
	],

	:init_module_field		=> { 'name' => 'unname', 'author' => 'unknown', 'version' => '1.0.0' },

	:init_gitinore_item		=> ["*.swp", "*.gem", "*~", "*.lock"],

	:init_scfg_item			=> [
		:module_require, :module_disable, :module_focus, :source,
		:lang, :db_connection, :environment, :bind, :port,
	],
}


