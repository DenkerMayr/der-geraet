#::RBNACL_LIBSODIUM_GEM_LIB_PATH = "D:/Ruby/Dependencies/Discord/libsodium.dll"
require 'discordrb'
require 'open-uri'
require 'certified'

bot = Discordrb::Commands::CommandBot.new token: 'Mjg2OTU2NzU0MjUwNDk4MDQ5.C5oRXA.yLI0pJcpWJfF8qJYKNKUIAlwGVM', client_id: 286956754250498049, prefix: '+'

#Global Variables
time_start = 0
uptime_counter = Time.now

#methods

def calc_time(past,future)
  timer = future - past
  timer_ms = timer % 1
  timer_ms = timer_ms *1000
  timer_ms = timer_ms.floor
  timer_s = timer.floor
  if timer_s >= 60
    timer_min = timer_s / 60
    timer_s = timer_s % 60
    if timer_min >= 60
      timer_h = timer_min / 60
      timer_min = timer_min % 60
    else
      timer_h = 0
    end
  else
    timer_h = 0
    timer_min = 0
  end
  "#{timer_h}h #{timer_min}min #{timer_s}s #{timer_ms}ms"
end

# This method call adds an event handler that will be called on any message that exactly contains the string "Ping!".
# The code inside it will be executed, and a "Pong!" response will be sent to the channel.
bot.message(with_text: 'Ping!') do |event|
	event.respond 'Pong!'
end

bot.message(with_text: 'Dominik') do |event|
	event.respond 'Hallo Dominik!'
end

bot.command(:cmd) do |event|
  event.respond '+cmd : gives this window.'
  event.respond '+randomcat : Gives random cats. <3'
  event.respond '+dice <int> : Let\'s roll some dice.'
  event.respond '+timer_start : Starts the timer.'
  event.respond '+timer_end : Stops timer and shows time.'
  event.respond '+uptime : Shows uptime.'
  event.respond '+exit : Closes bot.'
end

bot.command(:timer_start) do |event|
  time_start = Time.now
  event.respond 'Timer started.'
end

bot.command(:timer_end) do |event|
  if time_start != 0
    #time_end = Time.now
    time = calc_time(time_start,Time.now)
    time_start = 0
    event.respond time
  else
    event.respond 'Start the timer first.'
  end
end

bot.command(:uptime) do |event|
  #time_end = Time.now
  event.respond calc_time(uptime_counter,Time.now)
end

bot.command(:randomcat) do |event|
  file = open('http://random.cat/meow')
  contents = file.read
  contents.gsub!("{\"file\":\"", "")
  contents.gsub!("\\/", "/")
  contents.gsub!("\"}", "")
	event.respond contents
end

bot.command(:dice, min_args: 1, max_args: 1) do |event, dice_num|
  URL = "https://www.random.org/integers/?num=1&min=1&max=#{dice_num}&col=1&base=10&format=plain&rnd=new"
  file = open(URL)
  contents = file.read
  event.respond contents
end

bot.command(:exit) do |event|
  # This is a check that only allows a user with a specific ID to execute this command. Otherwise, everyone would be
  # able to shut your bot down whenever they wanted.
  break unless event.user.id == 173752508265660416 || 217289633426309120 # Replace number with your ID

  bot.send_message(event.channel.id, 'Bot is shutting down')
  exit
end

bot.run
