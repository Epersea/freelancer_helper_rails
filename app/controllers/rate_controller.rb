class RateController < ApplicationController
  def index
  end
  
  def new
  end

  def create
    rate_id = get_rate_id

    rate_calculator = RateCalculator.new(params, rate_id)
    rate_calculator.do

    @rate = Rate.find(rate_id)

    redirect_to show_rate_path(@rate)
  end

  def show
    @rate = Rate.find(params[:id])
  end

  def edit
    @rate = Rate.find(params[:id])
  end

  def update
    rate_id = params[:id]

    rate_calculator = RateCalculator.new(params, rate_id)
    rate_calculator.do

    @rate = Rate.find(rate_id)
    
    redirect_to show_rate_path(@rate)
  end

  private

  def get_rate_id
    rate = Rate.new
    rate.save

    rate.id
  end
end