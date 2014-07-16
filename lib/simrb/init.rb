require 'simrb/config'

unless File.exist? 'scfg'
	Simrb.p "This command only is used in root directory of project, no scfg file found"
	exit
end

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

# load modules
Smodules = Simrb.load_module

# scan file path
Sload 				= {}
Sload[:lang] 		= []
Sload[:main] 		= []
Sload[:tool] 		= []
Sload[:view] 		= []

Smodules.each do | name |
	Sload[:lang] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}#{Spath[:lang]}*.#{Scfg[:lang]}"]
	Sload[:tool] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}#{Spath[:box]}*.rb"]
	Sload[:main] 	+= Dir["#{Sroot}#{Spath[:module]}#{name}/*.rb"]
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

