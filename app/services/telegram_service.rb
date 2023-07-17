# frozen_string_literal: true

require 'telegram/bot'

class TelegramService
  def initialize(bot_token)
    @bot_token = bot_token
  end

  def send_message(chat_id, text)
    Telegram::Bot::Client.run(@bot_token) do |bot|
      bot.api.send_message(chat_id:, text:)
    end
  end

  def send_photo(chat_id, photo_url, caption = nil)
    Telegram::Bot::Client.run(@bot_token) do |bot|
      photo_file = URI.open(photo_url)
      bot.api.send_photo(chat_id:, photo: photo_file, caption:)
    end
  end
end
