# frozen_string_literal: true

require 'httparty'

class InstagramService
  BASE_URL = 'https://graph.instagram.com'

  def initialize(_access_token)
    @access_token = 'a2fd3e2a3970150f7feade4833f5b8e3'
  end

  def upload_story(media_file, sticker_data)
    media_id = upload_media(media_file)
    create_story(media_id, sticker_data)
  end

  def upload_carousel_story(media_files, sticker_data)
    media_ids = media_files.map { |media_file| upload_media(media_file) }
    create_carousel_story(media_ids, sticker_data)
  end

  def upload_photo(media_file, caption = nil)
    media_id = upload_media(media_file)
    create_post(media_id, caption)
  end

  def upload_carousel(media_files, captions = [])
    media_ids = media_files.map { |media_file| upload_media(media_file) }
    create_carousel(media_ids, captions)
  end

  def upload_reel(media_file, caption = nil)
    media_id = upload_media(media_file)
    create_reel(media_id, caption)
  end

  private

  def upload_media(media_file)
    url = "#{BASE_URL}/me/media"
    response = HTTParty.post(url, body: { access_token: @access_token, media_type: 'PHOTO' },
                                  headers: { 'Content-Type' => 'image/jpeg' }, query: { image_url: media_file })

    handle_response(response) do |data|
      data['id']
    end
  end

  def create_story(media_id, sticker_data)
    url = "#{BASE_URL}/me/stories"
    query_params = { access_token: @access_token, attached_media: [{ media_id: }], sticker: sticker_data }
    response = HTTParty.post(url, body: query_params)
    response['id']
  end

  def create_carousel_story(media_ids, sticker_data)
    url = "#{BASE_URL}/me/stories"
    attached_media = media_ids.map { |media_id| { media_id: } }
    query_params = { access_token: @access_token, attached_media:, sticker: sticker_data }
    response = HTTParty.post(url, body: query_params)
    response['id']
  end

  def create_post(media_id, caption = nil)
    url = "#{BASE_URL}/me/media_publish"
    query_params = { access_token: @access_token, creation_id: media_id, caption: }
    response = HTTParty.post(url, body: query_params)
    handle_response(response) do |data|
      data['id']
    end
  end

  def create_carousel(media_ids, captions = [])
    url = "#{BASE_URL}/me/media_publish"
    children = media_ids.each_with_index.map do |media_id, index|
      { media_id:, caption: captions[index] }
    end
    query_params = { access_token: @access_token, media_type: 'CAROUSEL_ALBUM', children: }
    HTTParty.post(url, body: query_params)
  end

  def create_reel(media_id, caption = nil)
    url = "#{BASE_URL}/me/media_publish"
    query_params = { access_token: @access_token, creation_id: media_id, caption: }
    HTTParty.post(url, body: query_params)
  end

  def handle_response(response)
    if response.success?
      yield response.parsed_response
    else
      error_message = response['error']['message'] if response['error']
      raise "Instagram API Error: #{error_message || response.code}"
    end
  rescue StandardError => e
    raise "Instagram API Error: #{e.message}"
  end
end
