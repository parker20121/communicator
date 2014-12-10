xmlfile = File.new("ipfw-players.xml","w")
xmlfile.puts "<?xml version='1.0'?>"
xmlfile.puts "<players>"

File.open("players.csv").each do | line |

	fields = line.split("\t")
	
	if fields.len > 2 
		puts "fields: #{fields} size: #{fields.size}"
		record = "\t<player "
		record << "first_name='" << fields[0].to_s.chomp! << "' "
		record << "last_name='" << fields[1].to_s.chomp! << "' "
		record << "years='" << fields[2].to_s.chomp! << "' "
		record << "home_town='" << fields[3].to_s.chomp! << "' "
		record << "high_school='" << fields[4].to_s.chomp! << "'/>"
		xmlfile.puts record
	end
	
end

xmlfile.puts "</players>"
xmlfile.close
