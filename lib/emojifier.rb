require 'colorize'
require 'slack-ruby-bot'
require 'uri'

require_relative 'image_formatter'
require_relative 'emoji_uploader'

SlackRubyBot::Client.logger.level = Logger::WARN

SlackRubyBot.configure do |config|
    config.send_gifs = false
end

module Emojifier
  class Bot < SlackRubyBot::Bot
    help do
      title 'Emojifier'
      desc "Emojify your Slack with a bot."

      command 'ping' do
        desc 'Responds with "pong"'
      end

      command 'add' do
        desc 'usage: `@emojifier add <emoji name> <image url>`'
      end
    end

    command 'ping' do |client, data, match|
      client.say(text: 'pong', channel: data.channel)
      puts "🏓  Ponging a ping".blue
    end

    command 'add' do |client, data, match|
      input = match[:expression]

      if input.nil?
        client.say(text: 'usage: `@emojifier add <emoji name> <image url>`', channel: data.channel)
        puts "⛔️  No input".red
        next
      end

      capture = (/(\w+)\s+(?:&lt;)(.+)(?:&gt;)/.match(input)) || /(\w+)\s+(?:<)(.+)(?:>)/.match(input)
      name = capture[1] if capture
      url = capture[2] if capture

      if name.nil? || url.nil? || url !~ URI::regexp # if url is nil OR url is not a valid url
        client.say(text: "I did not find an *emoji name* or *valid URL* in your message ಠ_ಠ\nusage: `@emojifier add <emoji name> <image url>`", channel: data.channel)
        puts "⛔️  Did not find emoji name or valid URL".red
        next
      end

      puts "ℹ️  Emoji request! Name: #{name} From: #{url}".light_blue
      
      emojified_image_path = ImageFormatter.emojify_image(url)

      if emojified_image_path.nil?
        client.say(text: "I could not find an image at that url ಠ_ಠ", channel: data.channel)
        puts "⛔️  Did not find image at URL".red
        next
      end

      puts "ℹ️  Temporary image path: #{emojified_image_path}".light_blue

      upload_succeeded = Uploader.upload_from_path(emojified_image_path, name)

      if upload_succeeded
        client.say(text: ":#{name}:", channel: data.channel)
        puts "✅  Successfully uploaded #{name}".green
      else
        client.say(text: "Hmm I got the emoji, but I couldn't upload it 🤔", channel: data.channel)
        puts "⛔️  Got emoji but could not upload".red
      end

      puts "=" * 80
    end
  end
end