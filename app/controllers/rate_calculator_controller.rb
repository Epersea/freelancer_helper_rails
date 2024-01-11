class RateCalculatorController < ApplicationController
  def new
    @rate_calculator = RateCalculator.new
  end

  def create

    rate_calculator = Rate.new(params["expenses"]["long_term"])
    long_term = rate_calculator.calculate_long_term
    annual = params["expenses"]["annual"]
    monthly = params["expenses"]["monthly"]
   
    @rate_calculator = RateCalculator.new
    @rate_calculator.col1 = long_term
    @rate_calculator.col2 = annual
    @rate_calculator.col3 = monthly

    @rate_calculator.save
    redirect_to show_rate_path(@rate_calculator)
  end

  def show
    @rate_calculator = RateCalculator.find(params[:id])
  end
end