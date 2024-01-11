class RateCalculatorController < ApplicationController
  def new
    @rate_calculator = RateCalculator.new
  end

  def create

    rate = Rate.new(params["expenses"]["long_term"])
    long_term = rate.calculate_long_term
    annual = params["expenses"]["annual"]
    monthly = params["expenses"]["monthly"]
   
    @rate_calculator = RateCalculator.new
    @rate_calculator.col1 = long_term
    
    @rate_calculator.col3 = monthly

    @rate_calculator.save
    @rate_calculator.col2 = rate.edit_annual(@rate_calculator.id)
    redirect_to show_rate_path(@rate_calculator)
  end

  def show
    @rate_calculator = RateCalculator.find(params[:id])
  end
end