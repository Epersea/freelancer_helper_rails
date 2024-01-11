class RateCalculatorController < ApplicationController
  def new
    @rate_calculator = RateCalculator.new
  end

  def create
    col1 = params["col1"].to_i * 2
    col2 = params["col2"].to_i * 2
    col3 = params["col3"].to_i * 2
    @rate_calculator = RateCalculator.new
    @rate_calculator.col1 = col1
    @rate_calculator.col2 = col2
    @rate_calculator.col3 = col3

    @rate_calculator.save
    redirect_to controller: 'rate_calculator', action: 'show', id: @rate_calculator.id
  end

  def show
    @rate_calculator = RateCalculator.find(params[:id])
  end

end