module External
  class FacebookGroups

    # Canada Deals
    GROUP_ID = '2139639556288622'

    def initialize
      @posts = []
      get_fb_group_posts
    end

    def get_fb_group_posts
      @graph = Koala::Facebook::API.new(SiteSetting.instance.facebook_access_token)
      @posts = @graph.get_connection(GROUP_ID, 'feed')

      rescue Koala::Facebook::AuthenticationError => e
        # Handle authentication errors
        puts "Authentication error: #{e.message}"
      rescue Koala::Facebook::ClientError => e
        # Handle other client errors
        puts "Client error: #{e.message}"
      rescue => e
        # Handle other errors
        puts "Error: #{e.message}"
    end
  end
end
