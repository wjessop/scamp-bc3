# Because of the say BC3 works we start with an open HTTP
# connection that we respond on with the result of the
# command, and a URL we can POST to to make follow-up
# responses. Responder is responsible for responding
# using the first HTTP response, and posting subsequent
# responses to the URL provided

require 'net/http'
require 'uri'
require 'thread'

class Scamp
	module BC3
		class Responder
			attr_reader :subsequent_post_uri, :initial_response_used

			def initialize(initial_http_response_object, subsequent_post_url)
				@initial_http_response_object = initial_http_response_object
				@subsequent_post_uri = URI("#{subsequent_post_url}.text".sub('http', 'https'))
				@response_wait_queue = Queue.new
				@initial_response_used = Mutex.new
			end

			def respond(message)
				if initial_response_used.try_lock # We're using the mutex as a one-time gate
					@initial_http_response_object.body = message
					@response_wait_queue.push(true)
				else
					http = Net::HTTP.new(subsequent_post_uri.host, subsequent_post_uri.port)
					http.use_ssl = true
					http.verify_mode = OpenSSL::SSL::VERIFY_PEER
					response = http.post(subsequent_post_uri.path, URI.encode_www_form([["content", message]]))
				end
			end

			def wait_for_response
				@response_wait_queue.pop
			end
		end
	end
end
