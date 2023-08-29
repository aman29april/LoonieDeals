# frozen_string_literal: true

# https://developers.facebook.com/docs/instagram-api/reference/ig-user/media
require 'httparty'

class InstagramService
  BASE_URL = 'https://graph.facebook.com'
  IG_USER_ID = ENV['IG_BUSINESS_ACC_ID']
  API_VERSION = 'v17.0'
  APP_ID = ENV['IG_APP_ID']
  APP_SECRET = ENV['IG_APP_SECRET']
  ACCESS_TOKEN = ENV['IG_ACCESS_TOKEN']

  REDIRECT_URL = 'http://localhost:3000/facebook_callback'

  def initialize
    @access_token = SiteSetting.instance.facebook_access_token
    @url = [BASE_URL, API_VERSION, IG_USER_ID].join('/')
    @authorization_url = "https://api.instagram.com/oauth/authorize?client_id=#{APP_ID}&redirect_uri=#{REDIRECT_URL}&scope=user_profile,user_media&response_type=code"

    @endpoints = {
      media: [@url, 'media'].join('/'),
      media_publish: [@url, 'media_publish'].join('/'),
      content_publishing_limit: [@url, 'content_publishing_limit'].join('/')
    }
  end

  def create_photo_post(media_files, caption = nil)
    if media_files.length == 1
      create_single_photo_post(media_files.first, caption)
    else
      create_carousel(media_files, caption)
    end
  end

  def create_carousel(media_files, caption = '')
    # upload carousel_item:
    children = media_files.map { |media_file| upload(media_file, { caption: '', is_carousel_item: true }) }

    # Create carousel container
    creation_id = create_carousel_container(children, caption)
    publish_carousel(creation_id)
  end

  def create_single_photo_post(media_file, caption = nil)
    media_id = upload(media_file, { caption: })
    create_post(media_id, caption)
  end

  alias send_photo create_single_photo_post

  def create_video_post(media_file, caption = nil)
    media_id = upload(media_file, { caption:, post_type: 'VIDEO' })
    create_post(media_id, caption)
  end

  alias send_video create_video_post

  # def upload_story(media_file, sticker_data)
  #   media_id = upload(media_file, { media_type: 'STORY' })
  #   create_story(media_id, sticker_data)
  # end

  # def upload_carousel_story(media_files, sticker_data)
  #   media_ids = media_files.map { |media_file| upload_media(media_file) }
  #   create_carousel_story(media_ids, sticker_data)
  # end

  def upload_reel(media_file, caption = nil)
    media_id = upload_media(media_file)
    create_reel(media_id, caption)
  end

  def get_publishing_limit; end

  def upload(url, options = {})
    validate_params(options)
    params =  { access_token: @access_token }.merge(options).compact.except(:post_type)

    post_type = options[:post_type]
    post_type = 'VIDEO' if url.split('.').last.downcase == 'mp4'
    post_type = 'PHOTO' if post_type.blank?
    url_key = post_type == 'PHOTO' ? :image_url : :video_url
    params[url_key] = url
    params[:media_type] = post_type if post_type.present? && post_type != 'PHOTO'

    endpoint = @endpoints[:media]
    response = HTTParty.post(endpoint, query: params)
    handle_response(response) do |data|
      data['id']
    end
  end

  def validate_params(options)
    allowed_keys = %i[media_type post_type is_carousel_item caption]
    extra_keys = options.keys - allowed_keys
    raise "Invaid keys passed: #{extra_keys}, allowed are: #{allowed_keys}" if extra_keys.any?

    media_type = options[:media_type]
    post_type = options[:post_type]

    raise "#{media_type} is Invalid Media Type" if media_type.present? && !%w[VIDEO REEL
                                                                              STORIES].include?(media_type)
    raise "#{post_type} is Invalid Post Type" if post_type.present? && !%w[PHOTO VIDEO].include?(post_type)
  end

  def upload_media(params)
    url = @endpoints[:media]
    response = HTTParty.post(url,
                             query: params)
    handle_response(response) do |data|
      data['id']
    end
  end

  def upload_photo(url, _caption = nil)
    upload url
  end

  def upload_video(url, _caption = nil)
    upload(url, post_type: 'VIDEO')
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
    url = @endpoints[:media_publish]
    query_params = { access_token: @access_token, creation_id: media_id, caption: }
    response = HTTParty.post(url, body: query_params)
    handle_response(response) do |data|
      data['id']
    end
  end

  def publish_carousel(creation_id)
    url = @endpoints[:media_publish]
    query_params = { access_token: @access_token, creation_id: }

    response = HTTParty.post(url, body: query_params)
    handle_response(response) do |data|
      data['id']
    end
  end

  def create_carousel_container(children, caption)
    url = @endpoints[:media]
    query_params = { access_token: @access_token, media_type: 'CAROUSEL', children:, caption: }
    response = HTTParty.post(url, body: query_params)
    handle_response(response) do |data|
      data['id']
    end
  end

  def create_reel(media_id, caption = nil)
    url = "#{BASE_URL}/me/media_publish"
    query_params = { access_token: @access_token, creation_id: media_id, caption: }
    HTTParty.post(url, body: query_params)
  end

  def exchange_code_for_access_token
    token_url = URI.parse('https://api.instagram.com/oauth/access_token')

    request_params = {
      client_id: APP_ID,
      client_secret: APP_SECRET,
      grant_type: 'authorization_code',
      redirect_uri: REDIRECT_URL,
      code:
    }

    response = Net::HTTP.post_form(token_url, request_params)
    response_body = JSON.parse(response.body)

    access_token = response_body['access_token']
    user_id = response_body['user_id']

    # Save and manage the access token securely
    # ...

    [access_token, user_id]
  end

  def handle_response(response)
    if response.success?
      yield response.parsed_response
    else
      error_message = response['error']['message'] if response['error']

      refresh_access_token if response['error']['code'] == 190
      raise "Instagram API Error: #{error_message || response.code}"
    end
  rescue StandardError => e
    raise "Instagram API Error: #{e.message}"
  end
end
