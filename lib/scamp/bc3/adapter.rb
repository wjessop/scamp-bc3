require 'thread'
require 'scamp/adapter'

class Scamp
	module BC3
		class Adapter < Scamp::Adapter
			def initialize(bot, opts)
				Scamp::BC3::Server.listen_address = opts.delete(:listen_address)
				Scamp::BC3::Server.listen_port = opts.delete(:listen_port)
				Scamp::BC3::Server.secret = opts.delete(:secret)
				Scamp::BC3::Server.message_callback = ->(context, message) {
					puts "Pushing #{context}, #{message} to channel"
					push [context, message]
				}
				super
			end

			def connect!
				Scamp::BC3::Server.instance
			end
		end
	end
end
