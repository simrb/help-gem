require File.expand_path('../lib/simrb/info', __FILE__)

include Simrb

Gem::Specification.new do |s|

	s.name 					= Simrb::Info[:name]
	s.date 					= Simrb::Info[:created]
	s.version 				= Simrb::Info[:version]
	s.email 				= Simrb::Info[:email]
	s.authors 				= Simrb::Info[:author]
 	s.homepage 				= Simrb::Info[:homepage]
	s.description 			= Simrb::Info[:description]
  	s.summary 				= Simrb::Info[:summary]
	s.license				= Simrb::Info[:license]

	s.executables 			= ['simrb']
	s.default_executable	= 'simrb'
#   s.files 				= `git ls-files`.split("\n")
	
	s.files					= [
		'lib/simrb.rb',
		'lib/simrb/info.rb',
		'lib/simrb/command.rb',
	]

end
