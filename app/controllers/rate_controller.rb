class RateController < ApplicationController
  def index
  end
  
  def new
  end

  def create
    sanitized_data = sanitize_form_data(params)
    rate_id = get_rate_id

    rate_calculator = RateCalculator.new(params, rate_id)
    rate_calculator.do

    @rate = Rate.find(rate_id)

    redirect_to show_rate_path(@rate)
  end

  def show
    @rate = Rate.find(params[:id])
  end

  private

  def sanitize_form_data(data)
    data.transform_values { |value| ActionController::Base.helpers.strip_tags(value) }
  end

  def get_rate_id
    rate = Rate.new
    rate.save

    rate.id
  end
end