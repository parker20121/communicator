
inFile = File.open("communicator-links.txt","r")
outFile = File.open("text-communicator-links.txt","w")

while ( line = inFile.gets )
	index = line.rindex('/')
	filename = line[ index..-2 ]
	link = "http://archive.org/stream#{filename}#{filename}_djvu.txt"
	outFile.puts link
end

inFile.close
outFile.close