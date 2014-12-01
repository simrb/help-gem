
# default path of project directory and module
Spath						= {

	# the required repository 
	:repo_dirs				=> [(File.expand_path("~/.simrb") + '/')],

	# default directory for saving the pulled module from remote
	:def_repo				=> 'default-repo/',

	# root directory path of project
	:module					=> 'modules/',
	:public					=> 'public/',
	:db_dir					=> 'db/',
	:upload_dir				=> 'db/upload/',
	:backup_dir				=> 'db/backup/',
	:download_dir			=> 'db/download/',
	:tmp_dir				=> 'tmp/',
	:cache_dir				=> 'tmp/cache/simrb/',
	:install_lock			=> 'tmp/install.lock',
	:log_dir				=> 'log/',
	:server_log				=> 'log/thin.log',
	:command_log			=> 'log/command_error_log.html',
	:schema					=> 'log/migrations/',

	# module directory path
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

# default setting options
Scfg						= {

	# disable the modules of current project
	:module_disable			=> [],

	# require the modules of local repository
	:module_require			=> [],

	:module_focus			=> nil,

	:user 					=> 'unknown',

	# default config filename
	:name 					=> 'scfg.rb',

	# overwrite the file Scfg[:name]
	:name_overwrite			=> "/scfg_copy.rb",

	:encoding				=> 'utf-8',
	:lang					=> 'en',
	:install_lock			=> 'yes',
	:db_connection			=> 'sqlite://db/data.db',
	:server 				=> 'thin',
	:bind 					=> '0.0.0.0',
	:port					=> 3000,

	:source					=> 'https://github.com/simrb/',

	# a default core repository for loading when the server booting
	:main_repo				=> 'main-repo',
	:test_repo				=> 'test-repo',

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
		:db_dir, :upload_dir, :backup_dir, :download_dir,
		:tmp_dir, :log_dir, :module, :schema
	],

	:init_module_field		=> {
		'name' => 'unname', 'author' => 'unknown', 'version' => '1.0.0' 
	},

	:init_gitinore_item		=> [
		"*.swo", "*.swp", "*.gem", "*~", "*.lock", "*.bak"
	],

}

# append the children repository
Spath[:repo_dirs] << (Spath[:repo_dirs][0] + Spath[:def_repo])
Spath[:repo_dirs] << (Spath[:repo_dirs][0] + Scfg[:main_repo] + '/')
