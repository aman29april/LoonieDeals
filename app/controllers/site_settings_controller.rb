# frozen_string_literal: true

class SiteSettingsController < ApplicationController
  before_action :find_site_setting, only: %i[edit update]

  def edit; end

  def update
    if @site_setting.update(site_setting_params)
      redirect_to edit_site_setting_path(@site_setting), notice: 'Site settings updated successfully.'
    else
      render :edit
    end
  end

  private

  def find_site_setting
    @site_setting = SiteSetting.instance
  end

  def site_setting_params
    params.require(:site_setting).permit(:ig_id, :ig_secret_token)
  end
end
