Sdocs = {}

module Simrb
	
	def self.docs args = []
		res 		= []
		i 			= 0
		docs_key 	= {}
		docs_val 	= {}
		Sdocs.each do | key, val |
			docs_key[i] = key
			docs_val[i] = val
			i = i + 1
		end

		if args.empty?
			res << 'please select the number before the list to see detials'
			docs_key.each do | i, key |
				res << "#{i.to_s}, #{key}"
			end
		else
			args.each do | i |
				res << (docs_val.include?(i.to_i) ? docs_val[i.to_i] : 'no document')
			end
		end
		res
	end

end
