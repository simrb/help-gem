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

Smodules.each do | name, path |
	Sload[:lang] 	+= Dir["#{path}#{Spath[:lang]}*.#{Scfg[:lang]}"]
	Sload[:tool] 	+= Dir["#{path}#{Spath[:store]}*.rb"]
	Sload[:tool] 	+= Dir["#{path}#{Spath[:tool]}*.rb"]
	Sload[:main] 	+= Dir["#{path}/*.rb"]
	Sload[:main] 	+= Dir["#{path}#{Spath[:logic]}*.rb"]
	Sload[:view]	<< "#{path}#{Spath[:view]}".chomp("/")
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

