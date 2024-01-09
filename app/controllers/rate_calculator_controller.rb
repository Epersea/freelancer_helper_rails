class RateCalculatorController < ApplicationController
  def show
    @rate_calculator = RateCalculator.new
  end
end