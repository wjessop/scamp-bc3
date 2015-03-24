require 'webrick'
require 'securerandom'
require 'uri'

class Scamp
	module BC3
		class Server
			include Singleton

			def self.listen_address=(value)
				@@listen_address = value
			end

			def self.listen_port=(value)
				raise ArgumentError, "Port must be a value between 1 and 65535 inclusive" unless value > 0 && value <= 65535
				@@listen_port = value
			end

			def self.secret=(value)
				raise ArgumentError, "Secret cannot be blank" if value.empty?
				@@secret = value
			end

			def self.message_callback=(value)
				@@message_callback = value
			end

			# Some sensible defaults. Almost certainly need to be overridden for a real bot
			@@listen_address = "127.0.0.1"
			@@listen_port = rand(65535-1024) + 1024
			@@secret = SecureRandom.hex

			def initialize()
				server = WEBrick::HTTPServer.new :BindAddress => @@listen_address, :Port => @@listen_port
				trap 'INT' do server.shutdown; exit end
				server.mount_proc "/#{@@secret}" do |req, res|
					decoded_post_data = extract_post_data(req.body)

					msg = Scamp::BC3::Message.new self,
						:body        => decoded_post_data["command"],
						:room        => "unknown",
						:mentionable => decoded_post_data["metadata[creator][mentionable]"],
						:familiar    => decoded_post_data["metadata[creator][familiar]"]

					responder = Scamp::BC3::Responder.new(res, decoded_post_data["metadata[callback_url]"])
					context = Scamp::BC3::Context.new responder, msg # self -> responder
					@@message_callback.call(context, msg)

					responder.wait_for_response
				end

				@server_thread = Thread.new {
					server.start
				}
			end

			private

			def extract_post_data(data_str)
				data = {}
				URI.decode_www_form(data_str).map{|k, v|data[k] = v}
				return data
			end
		end
	end
end
