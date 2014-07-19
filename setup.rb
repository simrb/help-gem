#!/usr/bin/env ruby

unless `gem list -i simrb`.index("true") == nil
	system("gem uninstall simrb")
end

system("gem build simrb.gemspec")
gemname = `ls | grep '.gem$'`.chomp("\n")
system("gem install #{gemname} -l")
