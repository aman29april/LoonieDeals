# frozen_string_literal: true

require 'telegram/bot'

class TelegramService
  def initialize
    @bot_token = ENV['TelegramBotToken']
    @chat_id = ENV['TelegramGroupChatId']
  end

  def send_message(text)
    Telegram::Bot::Client.run(@bot_token) do |bot|
      bot.api.send_message(chat_id:, text:)
    end
  end

  def send_photo(photo_url, caption = nil, data = {})
    Telegram::Bot::Client.run(@bot_token) do |bot|
      path_to_photo = File.expand_path(photo_url)
      file = File.open(path_to_photo)
      photo_upload = Faraday::UploadIO.new(file, 'image/jpeg')
      bot.api.send_photo(chat_id: @chat_id, photo: photo_upload, caption:, parse_mode: 'Markdown')

      if ENV['TelegramSendSeparately']
        data.each_value do |value|
          next if value.delete('`').blank?

          bot.api.send_message(chat_id: @chat_id, text: value, parse_mode: 'Markdown', disable_web_page_preview: true)
        end
      end
      # lines = caption.split("\n")
      # # Send each line of text as a separate message
      # lines.each do |line|
      #   bot.api.send_message(chat_id:@chat_id, text: line, parse_mode: 'Markdown')
      # end
    end
  end
end
