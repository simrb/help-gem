require 'sinatra'
require 'sequel'
require 'slim'

Svalid 	= {}
Sdata 	= {}

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

# default environment and db configuration setting
set :environment, Scfg[:environment].to_sym

# alter the path of template customized 
set :views, Sload[:view]
helpers do
	def find_template(views, name, engine, &block)
		Array(views).each { |v| super(v, name, engine, &block) }
	end
end

