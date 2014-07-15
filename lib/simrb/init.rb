require 'simrb/env'
require 'sinatra'
require 'sequel'
require 'slim'

unless File.exist? 'scfg'
	Simrb.p "This command only is used in root directory of project, no scfg file found"
	exit
end

Svalid 	= {}
Sdata 	= {}
Sload 	= {}

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

# load modules
Smodules = Simrb.load_module

# scan file path
Sload[:lang] 		= []
Sload[:main] 		= []
Sload[:tool] 		= []
Sload[:view] 		= []

Smodules.each do | name |
	Sload[:lang] 	+= Dir["#{Spath[:module]}#{name}#{Spath[:lang]}*.#{Scfg[:lang]}"]
	Sload[:tool] 	+= Dir["#{Spath[:module]}#{name}#{Spath[:box]}*.rb"]
	Sload[:main] 	+= Dir["#{Spath[:module]}#{name}/*.rb"]
	Sload[:view]	<< "#{Spath[:module]}#{name}#{Spath[:view]}".chomp("/")
end

# cache label statement of language
Sload[:lang].each do | lang |
	Sl << Simrb.yaml_read(lang)
end

# default environment and db configuration setting
set :environment, Scfg[:environment].to_sym

# alter the path of template customized 
set :views, Sload[:view]
helpers do
	def find_template(views, name, engine, &block)
		Array(views).each { |v| super(v, name, engine, &block) }
	end
end

# load main files that will be run later
Sload[:main].each do | path |
	require path
end

