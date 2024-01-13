class RateController < ApplicationController
  def index
  end
  
  def new
  end

  def create
    rate_calculator = RateCalculator.new(params)
    id = rate_calculator.do

    @rate = Rate.find(id)

    redirect_to show_rate_path(@rate)
  end

  def show
    @rate = Rate.find(params[:id])
  end
end