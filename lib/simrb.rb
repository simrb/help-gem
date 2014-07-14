
if ARGV[0] == 'start'
	require 'simrb/thin_start'
else
	require 'simrb/comd_start'
	Simrb::Scommand.run ARGV
end
