# frozen_string_literal: true

class SideBar
  attr_reader :current_deal, :current_store

  def initialize(current_deal: nil, current_store: nil)
    @current_deal = current_deal
    @current_store = current_store
  end

  def top_stores
    Store.top(10)
  end

  def top_deals
    deals = Deal.active.top_stories(6)
    deals = deals.excluding(@current_deal) if @current_deal
    deals
  end
end
