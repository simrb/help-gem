
if system("gem list -i simrb")
	system("gem uninstall simrb")
end

system("gem build simrb.gemspec")
gemname = `ls | grep '.gem$'`.chomp("\n")
system("gem install #{gemname} -l")
