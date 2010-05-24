class String
	def is_privmsg?
		self=~/^\:.*!.*\@.*PRIVMSG\ .* \:.*/
	end
	def is_part?
		self=~/^\:.*!.*\@.*PART\ \#.*/
	end
	def is_quit?
		self=~/^\:.*!.*\@.*QUIT\ :.*/
	end
	def is_join?
		self=~/^\:.*!.*\@.*JOIN\ :\#.*/
	end
	def is_op?
		self=~/^\:.*!.* MODE \#.* \+o .*/
	end
	def is_deop?
		self=~/^\:.*!.* MODE \#.* \-o .*/
	end
	def is_invite?
		self=~/^\:.*!.* INVITE .* \:.*/
	end
	def is_ping?
		self=~/^PING :.*/
	end
	def ping
		self.scan(/^PING :(.*)/).join	
	end
	def privmsg
		{:message => self.scan(/.* PRIVMSG .*? \:(.*)/).join.gsub("\r\n",''), :nickname => self.split(/\!/)[0].sub(/^\:/,''), :channel => self.scan(/.* PRIVMSG (.*?) \:.*/).join }
	end
end
