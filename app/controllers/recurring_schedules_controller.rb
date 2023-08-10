# frozen_string_literal: true

class RecurringSchedulesController < ApplicationController
  def new
    @recurring_schedule = RecurringSchedule.new
  end

  def create
    @recurring_schedule = RecurringSchedule.new(recurring_schedule_params)
    if @recurring_schedule.save
      redirect_to @recurring_schedule.deal, notice: 'Recurring schedule created successfully.'
    else
      render :new
    end
  end

  def edit
    @recurring_schedule = RecurringSchedule.find(params[:id])
  end

  def update
    @recurring_schedule = RecurringSchedule.find(params[:id])
    if @recurring_schedule.update(recurring_schedule_params)
      redirect_to @recurring_schedule.deal, notice: 'Recurring schedule updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @recurring_schedule = RecurringSchedule.find(params[:id])
    @recurring_schedule.destroy
    redirect_to @recurring_schedule.deal, notice: 'Recurring schedule deleted.'
  end

  private

  def recurring_schedule_params
    params.require(:recurring_schedule).permit(:deal_id, :recurrence_type, :day_of_week, :day_of_month)
  end
end
