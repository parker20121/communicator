require 'date'
require_relative 'index_page_by_year'
require_relative 'issues'

#
# Matt Parker
# July 27, 2012
#
# Generate indexes by decade.
#

if __FILE__ == $0 

	xmlFile = "corpus-201208062245.xml"

	puts "Building HMTL indexes..."

	issues = Issues.new
	html = IndexPageByYear.new

	issues.index( xmlFile, 1969, 1979 )
	html.write( "C:/Projects/communicator/index1970.html", issues )

	issues.index( xmlFile, 1980, 1989 )
	html.write( "C:/Projects/communicator/index1980.html", issues )

	issues.index( xmlFile, 1990, 1999 )
	html.write( "C:/Projects/communicator/index1990.html", issues )

	issues.index( xmlFile, 2000, 2010 )
	html.write( "C:/Projects/communicator/index2000.html", issues )

	issues.index( xmlFile, 1969, 2010 )
	html.write( "C:/Projects/communicator/indexall.html", issues )

	puts "Found #{issues.size} issues"

end

