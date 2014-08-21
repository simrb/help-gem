# 
# this is an entrance for running the task command in tool box
#

puts "="*30
require 'simrb/init'

module Simrb
	module Stool
	end
end

Sload[:tool].each do | path |
	require path
end
argv = ARGV.clone
# output = []

# command mode
if argv.count > 0 and Simrb::Stool.method_defined?(argv[0])
	
	helpers do
		include Simrb::Stool
	end

	get '/_tools' do
		method = argv.shift(1)[0]
		argv.empty? ? eval(method).to_s : eval("#{method} #{argv}").to_s
	end

	env = {'PATH_INFO' => "/_tools", 'REQUEST_METHOD' => 'GET', 'rack.input' => ''}
	status, type, body = Sinatra::Application.call env
	if status == 200
# 		body.each do | line |
# 			output << line
# 		end
	else
		File.open(Spath[:command_log], 'a+') do | f |
			f.write "\n#{'='*10}#{Time.now.to_s}\n#{'='*10}\n"
# 			f.write body
 			f.write (Sinatra::ShowExceptions.new(self).call(env.merge("HTTP_USER_AGENT" => "curl"))[2][0].to_s + "\n")
		end
# 		output << env["sinatra.error"]
		puts env["sinatra.error"]
	end

# document mode
else

	require 'simrb/help'

	Smodules.each do | name, path |
		Dir["#{path}#{Spath[:doc]}*.#{Scfg[:lang]}.rb"].each do | path2 |
			require(path2)
		end
	end

	argv.shift 1
	puts Simrb.help(argv)

end

puts "="*30
