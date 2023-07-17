# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @deals = Deal.all
  end
end
