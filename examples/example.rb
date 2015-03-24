require "rubygems"
require "bundler/setup"
require 'scamp'

$:.unshift File.join(File.dirname(__FILE__), '../lib')
require 'scamp/bc3'

Scamp.new do |bot|
	bot.adapter :bc3, Scamp::BC3::Adapter,
		:listen_address => '127.0.0.1',
		:listen_port => 5680,
		:secret => "fleebleebleoo"

	bot.match /^ping/ do |channel, msg|
		channel.reply "pong"
	end

	bot.connect!
end
