
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
	:store					=> '/store/',
	:lang					=> '/store/langs/',
	:doc					=> '/store/docs/',
	:schema					=> '/store/migrations/',
	:install				=> '/store/installs/',
	:modinfo				=> '/store/installs/_mods',
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


