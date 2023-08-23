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
      upload = photo_upload(photo_url)
      bot.api.send_photo(chat_id: @chat_id, photo: upload, caption:, parse_mode: 'Markdown')

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

  def send_photos(photos, caption = nil)
    Telegram::Bot::Client.run(@bot_token) do |bot|
      photos.each do |photo|
        upload = photo_upload(photo)
        bot.api.send_photo(chat_id: @chat_id, photo: upload, caption:)
      end
    end
  end

  def photo_upload(photo_url)
    path_to_photo = File.expand_path(photo_url)
    file = File.open(path_to_photo)
    Faraday::UploadIO.new(file, 'image/jpeg')
  end
end
