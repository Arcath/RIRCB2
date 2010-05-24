class Connection
	require 'socket'
	def initialize(server,botconfig)
		@server=server
		@botconfig=botconfig
		connect
		nickname
		connect_to_channels
		@status="live"
	end
	
	def nickname
		@nickname || set_nickname && @nickname
	end
	
	def disconnect
		@con.close
	end
	
	def receive
		@con.recv(512)
	end
	
	private
	
	def connect
		@con=TCPSocket.new(config["server"],config["port"])
	end
	
	def set_nickname
		send("USER " + @botconfig["nick"] + " arcath.net bla :RIRCB2")
		send("NICK " + @botconfig["nick"])
		msg=@con.recv(512)
		while msg !~ /^:.* 001.*/
			if msg =~ /Nickname is already in use/
				nick=(nick || @botconfig["nick"])+"_"
				send("NICK " + nick)
			end
			msg=@con.recv(512)
		end
		@nickname=(nick || @botconfig["nick"])
		if @botconfig["pass"] && @nickname == @botconfig["nick"] then
			send("PRIVMSG NickServ :IDENTIFY #{@botconfig["pass"]}")
			msg=@con.recv(512)
		end
	end
	
	def send(s)
		s=s.gsub(/\n/,'').gsub(/\r/,'')
		@con.send(s +"\n", 0)
	end
	
	def join(chan)
		send("JOIN #{chan}")
	end
	
	def pong(server)
		send("PONG #{server}")
	end
	
	def privmsg(privmsg)
		send("PRIVMSG #{privmsg[:channel]} :#{privmsg[:message]}")
	end
	
	def part(chan)
		send("PART #{chan} :Bye Bye")
	end
	
	def disconnect
		@con.close
	end
end
