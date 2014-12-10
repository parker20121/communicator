require_relative 'issue'
require 'rexml/document'

#
#
#
class Issues < Array

	attr_reader :start_year, :end_year
	
	def index( xml_file_name, start_year, end_year )

		self.clear
		 
		@start_year = start_year
		@end_year = end_year
		
		xml_file = File.new( xml_file_name, "r" )
		doc = REXML::Document.new xml_file

		for i in start_year..end_year

			puts "Processing year #{i}..."
			
			doc.elements.each( "ipfw-communicator/communicator[@year='#{i}']" ) { | issueXml |
				soccer = issueXml.attributes["soccer"].to_i
				puts "loading soccer #{i} : #{soccer}"
				pub_date = issueXml.attributes["date"]
				link = issueXml.attributes["online"]
				year = issueXml.attributes["year"]
				
				issue = Issue.new( year, pub_date, link, soccer )
				self << issue
				#puts "Added issue: #{year} #{pub_date}"
			}

		end	
	
		xml_file.close
		
	end

end