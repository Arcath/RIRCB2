namespace :server do
	desc "Add a server to the config"
	task :add, :key, :server, :port do |t, args|
		yaml={}
		yaml["key"] = args[:key]
		yaml["server"] = args[:server]
		yaml["port"] = (args[:port] || 6667)
		File.open("bot/servers/#{args[:key]}.yml", File::WRONLY|File::TRUNC|File::CREAT) do |out|
			YAML.dump(yaml, out)
		end
		puts "Added Server"
	end
	
	desc "Enable a server"
	task :enable, :server do |t, args|
		if File.exists? "bot/servers/#{args[:server]}.yml"
			puts "Enabling #{args[:server]}"
			exec "ln -s ../#{args[:server]}.yml bot/servers/enabled/#{args[:server]}.yml"
		else
			puts "#{args[:server]} doesn't exist!"
		end
	end
	
	desc "Disable a server"
	task :disable, :server do |t, args|
		puts "Disabling #{args[:server]}"
		exec "rm bot/servers/enabled/#{args[:server]}.yml"
	end
	
	desc "List avaliable servers"
	task :list do
		Dir['bot/servers/*.yml'].map { |server| puts server.scan(/servers\/(.*?).yml/).join unless server =~ /enabled/ }
	end
	
	desc "List enabled servers"
	task :enabled do
		Dir['bot/servers/enabled/*'].map { |server| puts server.scan(/enabled\/(.*?).yml/).join }
	end
end
