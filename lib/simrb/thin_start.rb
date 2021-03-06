# 
# this is an entrance to start the web server
#

require 'simrb/init'

set :run, true
set :server, Scfg[:server]
set :bind, Scfg[:bind]
set :port, Scfg[:port]

if Scfg[:environment] == 'production'

	Process.daemon Sroot
# 	system("echo #{Process.pid} > #{Spath[:tmp_dir]}pid")
 
	if Scfg[:server_log_mode] == 'file'
		log = File.new(Spath[:server_log], "a+") 
		$stdout.reopen(log)
		$stderr.reopen(log)

		$stderr.sync = true
		$stdout.sync = true
	end
end

