class Bot
	def initialize
		@servers=[]
		@run = true
		Dir['bot/servers/enabled/*.yml'].map { |f|  @servers.push(Server.new(f.scan(/bot\/servers\/enabled\/(.*?).yml/).join,config)) }
	end
	
	def config
		@config || get_config && @config
	end
	
	def thread
		@servers.each do |server|
			Thread.new { server.run }
			server = nil if server.status == "kill"
		end
		kill?
	end
	
	def run?
		@run
	end
	
	private
	
	def get_config
		@config=YAML::load_file("bot/config.yml")	
	end
	
	def kill?
		kill=false
		@servers.map { |server| kill = true unless server}
		kill
	end
end
