#
#
#
class Statistic < Hash

	attr_reader :max
	
	def initialize( title )
		@title = title
		@max = 0
	end
	
	def count( key, value )
	
		self[key] = self[key].to_i + value
		
		if self[key].to_i > @max.to_i
		    @max = self[key].to_i
		end
		
	end
	
	def to_s
		puts @title
		puts "============"
		keys.each do | key | 
			puts "#{key} #{self[key]}" 
		end
	end
	
end