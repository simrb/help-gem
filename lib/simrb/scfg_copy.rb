
Scfg[:encoding]			= 'utf-8'
Scfg[:lang]				= 'en'
Scfg[:install_lock]		= 'yes'

Scfg[:db_connection]	= 'sqlite://db/data.db'
Scfg[:bind]				= '0.0.0.0'
Scfg[:port]				= 3000

# options: development, production, test
Scfg[:environment]		= 'development'

# Scfg[:module_require]	= ['base','data','view','file','admin','user']

# your directory path of local
# Spath[:repo_dirs][0]	= (File.expand_path("~/.simrb") + '/')

# append anthor repository to repo variable
# Spath[:repo_dirs] << "/home/my/repo"
#
# or, overwrite those default repositories
# Spath[:repo_dirs] = ["/home/my/repo1", "/home/my/repo2"]
