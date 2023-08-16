# frozen_string_literal: true

class ReferralCodesController < ApplicationController
  before_action :set_store
  before_action :set_referral_code, only: %i[edit update destroy]

  def new
    @referral_code = @store.referral_codes.build
  end

  def create
    @referral_code = @store.referral_codes.build(referral_code_params)
    if @referral_code.save
      redirect_to @store, notice: 'Referral code was successfully created.'
    else
      render :new
    end
  end

  def update
    if @referral_code.update(referral_code_params)
      redirect_to @store, notice: 'Referral code was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @referral_code.destroy
    redirect_to @store, notice: 'Referral code was successfully destroyed.'
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_referral_code
    @referral_code = @store.referral_codes.find(params[:id])
  end

  def referral_code_params
    params.require(:referral_code).permit(:referal_link, :referal_code, :referal_text, :position, :enabled)
  end
end
