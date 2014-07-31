# 
# this is a configuration file and loading workflow of application
#

require 'simrb/config'

Simrb.root_dir_force

# increase language block
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

# scan file path
Sload 				= {}
Sload[:lang] 		= []
Sload[:main] 		= []
Sload[:tool] 		= []
Sload[:view] 		= []

Smodules.each do | name |
	Sload[:lang] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}#{Spath[:lang]}*.#{Scfg[:lang]}"]
	Sload[:tool] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}#{Spath[:store]}*.rb"]
	Sload[:tool] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}#{Spath[:tool]}*.rb"]
	Sload[:main] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}/*.rb"]
	Sload[:main] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}#{Spath[:logic]}*.rb"]
	Sload[:view]	<< "#{Sroot}#{Spath[:module]}#{name}#{Spath[:view]}".chomp("/")
end

# cache label statement of language
Sload[:lang].each do | lang |
	Sl << Simrb.yaml_read(lang)
end

# lood the hook of default configure
require "simrb/hook"

# load main files that will be run later
Sload[:main].each do | path |
	require path
end

