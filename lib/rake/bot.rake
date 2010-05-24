namespace :bot do
	desc "Starts the Bot"
	task :start do
		puts "Starting Bot"
		exec "screen -d -m -S RIRCB ruby script/run"
	end
	
	desc "Kills the bot process, try not to use this"
	task :terminate do
		system "screen -ls > /tmp/screenlist.tmp"
		f=File.new("/tmp/screenlist.tmp", "r")
		begin
			while (line = f.readline)
				pid=line.scan(/\t(.*?)\.RIRCB/) if line =~ /RIRCB/
			end
		rescue EOFError
			f.close
		end
		if pid
			puts "Terminating Bot"
			exec "kill #{pid}"
		else
			puts "Bot isnt running"
		end
	end
	
	desc "Configure the Bot"
	task :configure do
		yaml={}
		puts "Nickname:"
		yaml["nick"]=STDIN.gets.chomp
		puts "Ident Password:"
		yaml["pass"]=STDIN.gets.chomp
		File.open("bot/config.yml", File::WRONLY|File::TRUNC|File::CREAT) do |out|
			YAML.dump(yaml, out)
		end
	end
end
