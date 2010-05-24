require 'yaml'

Dir.glob('lib/rake/*.rake').each { |r| import r }

desc "Help Message"
task :help do
	puts "Rake tasks are broken up into groups"
	puts "Server Tasks:"
	puts "	add"
	puts "		This is used to add a server to the bot."
	puts "		syntax: \"rake server:add[\"name\",\"address\",\"port\"]"
	puts "		name is used to identify the server, can be anything you want"
	puts "		address is the url/ip of the server"
	puts "		port is the port used to connect (usually 6667)"
end
