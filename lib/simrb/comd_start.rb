require 'simrb/config'

module Simrb

	class Scommand

		@repos_path 	= "https://github.com/"

		@gemfile_path 	= "/boxes/misc/Gemfile"

		@app_name		= "myapp"

		@module_name 	= "system"

		@args			= []

		def initialize args
			@cmd 	= args.count > 0 ? args.shift : ''
			@args	= args unless args.empty?
		end

		def run
			if Scommand.private_method_defined? @cmd
				self.send(@cmd)
			else
				Simrb.p "No #{@cmd} command found"
			end
		end

		private

			# initialize a project directory
			#
			# == Example
			# 
			# 	$ simrb init myapp
			#
			def init
				@app_name = @args[0] if @args[0]

				# generate module directories and files
				Dir.mkdir @app_name
				Dir.chdir @app_name

				Scfg[:init_root_path].each do | item |
					path = "#{Spath[item]}"
					Simrb::path_init path
				end

				# initialize scfg file
				data = {}
				Scfg[:init_scfg_item].each do | item |
					data[item] = Scfg[item]
				end
				Simrb.yaml_write('scfg', data)

				# initialize rubygem bundled
# 				mode = "develpment"
# 				if @args.include? '--dev'
# 					mode = "production"
# 				end
# 				system("bundle install --gemfile=#{@app_name}/apps/#{@module_name}#{@gemfile_path} --without=#{mode}")

				Simrb.p "Successfully initialized"
			end

			# create a module, initialize default paths of file and directory
			#
			# == Example
			# 
			# 	$ simrb new blog
			#
			def new
				@args.each do | module_name |
					# module root dir
					Simrb::path_init "#{Spath[:apps]}#{module_name}/"

					Dir.chdir "."

					# module sub dir
					Scfg[:init_module_path].each do | item |
						path = "#{Spath[:apps]}#{module_name}#{Spath[item]}"
						Simrb::path_init path
					end

					# fill text to file for module info
					text = [{ 'name' => module_name }]
					Simrb.yaml_write "#{Spath[:apps]}#{module_name}#{Spath[:modinfo]}", text

					path = "#{Spath[:apps]}#{module_name}#{Spath[:gitignore]}"
					File.open(path, "w+") do | f |
						f.write "*.swp\n*.gem\n*~"
					end
				end

				Simrb.p "Successfully initialized"
			end

			# clone a module from remote repository to local
			#
			# == Example
			# 
			# 	$ simrb clone simrb/system
			#
			def clone
				system("git clone #{@repos_path}#{args[0]}.git modules/#{args[0].split('/').last}")
				Simrb.p "The copy of module is built completely"
			end

			# kill the current process of Simrb of that is running in background
			#
			# == Example
			#
			# 	$ simrb kill
			#
			def kill
				s = `ps -ax | grep 'simrb start'`
				s = s.split("\n")[0].split(" ")[0]
# 				s = `cat #{Spath[:tmp_dir]}pid`.split("\n")[0]
# 				`rm #{Spath[:tmp_dir]}pid`
				system("kill #{s}")
				Simrb.p "The process #{s} of web server has been killed yet"
			end

			# display the basic inforamtion of current version of Simrb
			#
			# == Example
			#
			# 	$ simrb info
			#
			def info
				require 'simrb/info'
				Simrb.p Simrb::Info
			end

	end

end

app = Simrb::Scommand.new ARGV
app.run
