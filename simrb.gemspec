require File.expand_path('../lib/simrb/info', __FILE__)

Gem::Specification.new do | s |

	s.name 					= Simrb::Info[:name]
	s.date 					= Simrb::Info[:created]
	s.version 				= Simrb::Info[:version]
	s.email 				= Simrb::Info[:email]
	s.authors 				= Simrb::Info[:author]
 	s.homepage 				= Simrb::Info[:homepage]
	s.description 			= Simrb::Info[:description]
  	s.summary 				= Simrb::Info[:summary]
	s.license				= Simrb::Info[:license]
	s.rubyforge_project 	= s.name

	s.executables 			= `ls bin`.split("\n")
	s.default_executable	= 'simrb'
	s.files 				= `ls lib/simrb`.split("\n").map{|f| "lib/simrb/#{f}"}.unshift("lib/simrb.rb")

	s.add_runtime_dependency "sinatra", ["= 1.4.5"]
	s.add_runtime_dependency "sequel", ["= 4.15.0"]
	s.add_runtime_dependency "slim", ["= 2.1.0"]
	s.add_runtime_dependency "thin", ["= 1.6.3"]

end
