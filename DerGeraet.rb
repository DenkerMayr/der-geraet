#::RBNACL_LIBSODIUM_GEM_LIB_PATH = "D:/Ruby/Dependencies/Discord/libsodium.dll"
require 'discordrb'
require 'open-uri'

bot = Discordrb::Commands::CommandBot.new token: 'Mjg2OTU2NzU0MjUwNDk4MDQ5.C5oRXA.yLI0pJcpWJfF8qJYKNKUIAlwGVM', client_id: 286956754250498049, prefix: '+'

# This method call adds an event handler that will be called on any message that exactly contains the string "Ping!".
# The code inside it will be executed, and a "Pong!" response will be sent to the channel.
bot.message(with_text: 'Ping!') do |event|
	event.respond 'Pong!'
end

bot.message(with_text: 'Dominik') do |event|
	event.respond 'Hallo Dominik!'
end

bot.command(:randomcat) do |event|
  file = open('http://random.cat/meow')
  contents = file.read
  contents.gsub!("{\"file\":\"", "")
  contents.gsub!("\\/", "/")
  contents.gsub!("\"}", "")
	event.respond contents
end

bot.command(:play) do |event|
	#bot.send_message(event.channel.id, 'Should start playing any moment now')
	channel = event.user.voice_channel
	next bot.send_message(event.channel.id, 'You\'re not in any voice channel!') unless channel
	bot.voice_connect(channel)
  #bot.send_message(event.channel.id, 'Connected to voice channel: ' + channel.name)

	voice_bot = event.voice
  voice_bot.play_file('data/music.mp3')
end

bot.command(:exit) do |event|
  # This is a check that only allows a user with a specific ID to execute this command. Otherwise, everyone would be
  # able to shut your bot down whenever they wanted.
  break unless event.user.id == 173752508265660416 || 217289633426309120 # Replace number with your ID

  bot.send_message(event.channel.id, 'Bot is shutting down')
  exit
end

bot.run
