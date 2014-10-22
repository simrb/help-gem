
Scfg[:encoding]			= 'utf-8'
Scfg[:lang]				= 'en'
Scfg[:install_lock]		= 'yes'

Scfg[:repo_dirs]		= [(File.expand_path("~/.simrb") + '/')]
# Scfg[:module_require]	= ['base','data','view','file','admin','user','test','www']

Scfg[:db_connection]	= 'sqlite://db/data.db'
Scfg[:bind]				= '0.0.0.0'
Scfg[:port]				= 3000

# options: development, production, test
Scfg[:environment]		= 'development'
