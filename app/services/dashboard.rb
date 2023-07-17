# frozen_string_literal: true

class Dashboard
  attr_reader :user, :deals, :tag, :filter

  def initialize(deals: nil, tag: nil, filter: nil, user: nil)
    @user = user
    @deals = deals
    @tag = tag
    @filter = filter
  end

  def featured_tags
    # Tag.where(featured: true)
    Tag.all
  end

  def following_tags
    user&.following_tags
  end

  def all_tags
    Tag.all.limit(50)
  end

  def top_stories
    Deal.published.top_stories(5)
  end

  def new_post
    @user.deals.new
  end

  def filtered?
    filter.present?
  end

  def top_stories?
    filter == :top_stories
  end
end
