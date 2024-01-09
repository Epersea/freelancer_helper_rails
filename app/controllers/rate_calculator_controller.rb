class RateCalculatorController < ApplicationController
  def show
    @rate_calculator = RateCalculator.new
  end

  def create
    params = rate_calculator_params
    col1 = params["col1"].to_i * 2
    col2 = params["col2"].to_i * 2
    col3 = params["col3"].to_i * 2
    @rate_calculator = RateCalculator.new
    @rate_calculator.col1 = col1
    @rate_calculator.col2 = col2
    @rate_calculator.col3 = col3
    @rate_calculator.save
    if @rate_calculator.save
      redirect_to @rate_calculator
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rate_calculator_params
    params.require(:rate_calculator).permit(:col1, :col2, :col3)
  end
end