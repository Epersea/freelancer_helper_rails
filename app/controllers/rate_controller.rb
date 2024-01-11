class RateController < ApplicationController
  def new
  end

  def create
    rate_calculator = RateCalculator.new(params["expenses"]["long_term"])
    long_term = rate_calculator.calculate_long_term
   
    @rate = Rate.new
    @rate.annual_expenses = long_term
    @rate.save
    
    rate_calculator.edit_annual(@rate.id)
    redirect_to show_rate_path(@rate)
  end

  def show
    @rate = Rate.find(params[:id])
  end
end