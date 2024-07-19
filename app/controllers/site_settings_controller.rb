# frozen_string_literal: true

class SiteSettingsController < ApplicationController
  before_action :find_site_setting

  def edit; end

  def update
    if @site_setting.update(site_setting_params)
      redirect_to edit_site_setting_path(@site_setting), notice: 'Site settings updated successfully.'
    else
      render :edit
    end
  end

  def create_flyer_deals
    store_names = ['Freshco', 'Food Basics', 'Walmart', 'No Frills']
    title = 'Weekly picks'
    category = [Category.grocery]
    starts_at, expiration_date = DateUtil.flyer_start_end_dates
    Store.where(name: store_names).each do |store|
      Deal.new(title: title, store: store, categories: category, starts_at: starts_at, expiration_date: expiration_date, kind: Deal.kinds[:flyer_deal]).save!
    end

    redirect_to edit_site_setting_path(@site_setting), notice: 'Flyer Deals created!'
  end

  private

  def find_site_setting
    @site_setting = SiteSetting.instance
  end

  def site_setting_params
    params.require(:site_setting).permit(:ig_id, :ig_secret_token)
  end
end
