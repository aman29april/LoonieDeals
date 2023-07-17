# frozen_string_literal: true

require 'telegram/bot'
require 'koala'
require 'httparty'

class SocialMediaService
  def initialize(text = nil, image_url = nil)
    @image_url = image_url
    @text = text

    @bot_token = '6371216873:AAEy7few3VoaaNd2_8iPC5O9fji5wNi8Vs4'
    @telegram_chat_id = '-1001807565212'
    @facebook_access_token = ''
  end

  def post_to_telegram
    Telegram::Bot::Client.run(@telegram_chat_id) do |bot|
      if @image_url
        photo_url = URI.parse(@image_url)
        photo_file = URI.open(photo_url)
        bot.api.send_photo(chat_id: @chat_id, photo: photo_file, caption: @text)
      else
        bot.api.send_message(chat_id: @chat_id, text: @text)
      end
    end
  end

  def post_to_facebook
    graph = Koala::Facebook::API.new(@facebook_access_token)
    options = { message: @deal_text }

    if @image_url
      picture_url = @image_url
      options[:picture] = picture_url
    end

    graph.put_connections('me', 'feed', options)
  end

  def post_to_instagram
    # Prepare the request URL
    url = 'https://graph.instagram.com/me/media'

    # Create the request body
    body = {
      caption: @deal_text,
      image_url: @image_url,
      access_token: @access_token
    }

    # Make the request to post on Instagram
    response = HTTParty.post(url, body:)

    # Process the response as needed
    if response.success?
      # Handle successful post
    else
      # Handle failed post
    end
  end

  def post_to_social_media(deal_text, image_url = nil)
    post_to_telegram(deal_text, image_url)
    post_to_facebook(deal_text, image_url)
    post_to_instagram(deal_text, image_url)
  end
end
