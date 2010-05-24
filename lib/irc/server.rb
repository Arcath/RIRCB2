class Server < Connection
	def config
		@config || get_config && @config
	end
	
	def channels
		@channels || get_channels && @channels
	end
	
	def connect_to_channels
		channels.map { |chan| join(chan) }
	end
	
	def run
		received=receive
		if received.is_ping? then
			pong(received.ping)
		elsif received.is_privmsg? then
			pass=received.privmsg
			pass[:mynickname]=nickname
			response=Response.new(pass).output
			privmsg(response)
			eval "#{response[:invoke]}" if response[:invoke]
		end
		
	end
	
	def status
		@status
	end
	
	private
	
	def get_config
		@config=YAML::load_file("bot/servers/#{@server}.yml")	
	end
	
	def get_channels
		@channels=YAML::load_file("bot/channels/#{@server}.yml")["channels"]
	end
	
	def kill
		@status = "kill"
		channels.map { |chan| part(chan) }
		sleep 1
		disconnect
	end
end
