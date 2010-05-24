class Response
	def initialize(privmsg)
		@privmsg=privmsg
	end
	def message
		if @privmsg[:message] =~ /Goodbye #{@privmsg[:mynickname]}/ then
			@invoke="kill"
			return "Goodbye"
		end
	end
	def channel
		if @privmsg[:channel] == @privmsg[:mynickname] then
			return @privmsg[:nickname]
		else
			return @privmsg[:channel]
		end
	end
	def output
		{:message => message, :channel => channel, :invoke => @invoke}
	end
end
