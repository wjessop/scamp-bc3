class Scamp
	module BC3
		class Context
			attr_reader :responder, :message

			def initialize(responder, msg)
				@responder = responder
				@message = msg
			end

			def say(msg)
				puts "Saying with #{msg}"
				responder.respond msg
			end

			def reply(msg)
				puts "Replying with #{msg}"
				responder.respond "#{message.familiar}: #{msg}"
			end

			def paste(text)
				puts "Pasting with #{text}"
				responder.respond text
			end

			def play(sound)
				puts "Playing #{sound}"
				responder.respond "/play #{sound}"
			end

			%w(crickets drama greatjob live nyan pushit rimshot secret tada tmyk trombone vuvuzela yeah).each do |sound|
				define_method sound do
					responder.respond "/play #{sound}"
				end
			end
		end
	end
end