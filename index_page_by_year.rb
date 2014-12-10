require_relative 'issue'
require_relative 'statistic'

#
#  Output summarized results in stoplight chart format.
#  Articles are indexed by article number by year, which
#  each is graded with icons representing yes (green), 
#  no (red), or maybe (yellow).
# 
class IndexPageByYear

	@@SOCCER_IMAGE = "yes.png"
	@@UNLIKELY_IMAGE = "maybe.png"
	@@NO_SOCCER_IMAGE = "no.png"
	@@NULL_IMAGE = "null.png"
	@@STYLESHEET_LINK = "soccer-index.css"
	
	def write( file_name, issues )

		start_year = issues.start_year
		end_year = issues.end_year
		
		freq_by_year = Statistic.new("Frequency by Year")
		soccer_by_year = Statistic.new("Soccer by Year")
		
		issues.each do | issue |
			freq_by_year.count( issue.year, 1 )
			soccer_by_year.count( issue.year, issue.soccer.to_i )
		end
		
			# Show statistics
		puts freq_by_year
		puts ""
		puts soccer_by_year
		
		file = File.new( file_name, "w")
		
		# Write start of HTML page
		file.puts "<html>"
		file.puts "   <head>"
		file.puts "      <title>IPFW Soccer Index #{start_year}-#{end_year}</title>"
		file.puts "      <link rel=stylesheet href='#{@@STYLESHEET_LINK}' type='text/css'/>"
		file.puts "   </head>"
		file.puts "   <body>"
		file.puts "      <p class='title'>Communicator Issues by Year</p>"
		file.puts "      <table>"

		max = freq_by_year.max.to_i
		puts "Total max #{max}"
		
			# Write header row.
		file.puts "      <tr class='header'><td>Year</td>"
		for i in 1..max
			file.puts "<td class='issue'>#{i}</td>"
		end
		file.puts "      </tr>"
		
			# Writer content
		start_row = 1
		column_count = freq_by_year[issues.start_year.to_s].to_i
		puts "#{issues.start_year} column count #{column_count}"
			
			# Build table of linked issues
		issues.sort.each do | issue |
				
				# Start a new row based on year
			if start_row == 1
				file.puts "         <tr class='year'><td>#{issue.year}</td>"
				column_count = 1
				start_row = 0
			end
			
			row_max = freq_by_year[issue.year.to_s].to_i
			
				# Write the cell and set the page link with the image.
			#puts "soccer #{issue.soccer}"
			
			if issue.soccer.to_i == 2
			    image_link = @@SOCCER_IMAGE
			elsif issue.soccer.to_i == 1
				image_link = @@UNLIKELY_IMAGE
			else
				image_link = @@NO_SOCCER_IMAGE
			end
			
			file.puts "            <td><a href='#{issue.link}'><img src='#{image_link}' alt='#{issue.pub_date}'/></a></td>"
			
				# Write the end of the row and ready the next one.
			if column_count == row_max
				((column_count+1)..max).each { file.puts "<td><img src='#{@@NULL_IMAGE}' alt=''/></td>" }
				file.puts "         </tr>"
				start_row = 1
			else
				column_count += 1
			end
			
		end

			# Write rows
		file.puts "      </table>"
		file.puts "   </body>"
		file.puts "</html>"

		file.close
	
	end

end