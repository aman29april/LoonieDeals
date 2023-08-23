# frozen_string_literal: true

class RecurringSchedulesController < ApplicationController
  before_action :set_deal
  before_action :set_resource, only: %i[update edit destroy]

  def index
    @recurring_schedules = @deal.recurring_schedules
  end

  def new
    @recurring_schedule = @deal.recurring_schedules.new
  end

  def create
    @recurring_schedule = @deal.recurring_schedules.new(recurring_schedule_params)
    if @recurring_schedule.save
      redirect_to deal_recurring_schedules_path(@deal), notice: 'Recurring schedule created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @recurring_schedule.update(recurring_schedule_params)
      redirect_to deal_recurring_schedules_path(@deal), notice: 'Recurring schedule updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @recurring_schedule.destroy
    redirect_to deal_recurring_schedules_path(@deal), notice: 'Recurring schedule deleted.'
  end

  private

  def recurring_schedule_params
    params.require(:recurring_schedule).permit(:deal_id, :recurrence_type, :day_of_week, :day_of_month)
  end

  def set_deal
    @deal = Deal.friendly.find(params[:deal_id])
  end

  def set_resource
    @recurring_schedule = RecurringSchedule.find(params[:id])
  end
end
