namespace :channel do
	desc "Add a channel"
	task :add, :server, :channel do |t, args|
		if Dir['bot/servers/*.yml'].include? "bot/servers/#{args[:server]}.yml"
			begin
				yaml=YAML::load_file("bot/channels/#{args[:server]}.yml")
			rescue
				yaml={}
				yaml["channels"]=[]
			end
			yaml["channels"].push(args[:channel])
			File.open("bot/channels/#{args[:server]}.yml", File::WRONLY|File::TRUNC|File::CREAT) do |out|
				YAML.dump(yaml, out)
			end
			puts "Added Channel"	
		else
			puts "Specified Server does not exist"
		end
	end
	
	desc "Remove Channel"
	task :remove, :server, :channel do |t, args|
		del=nil
		if Dir['bot/servers/*.yml'].include? "bot/servers/#{args[:server]}.yml"
			yaml=YAML::load_file("bot/channels/#{args[:server]}.yml")
			i=0
			yaml["channels"].each do |chan|
				del=i if chan == args[:channel]
				i+=1
			end
			if del != nil
				yaml["channels"].slice! del
				puts "Channel Removed"
				File.open("bot/channels/#{args[:server]}.yml", File::WRONLY|File::TRUNC|File::CREAT) do |out|
					YAML.dump(yaml, out)
				end
			else
				puts "Channel doesnt exist"
			end
		else
			puts "Specified Server does not exist"
		end
	end
end
