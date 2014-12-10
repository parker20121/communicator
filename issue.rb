require 'date'

#
#
#
class Issue

	include Comparable

	attr_accessor :year, :pub_date, :link, :soccer
	
	def initialize( year, pub_date, link, soccer )
		@year = year
		@pub_date = Date.parse( pub_date )
 		@link = link
		@soccer = soccer
	end
	
	def <=>(other)
		@pub_date <=> other.pub_date
	end
	
end