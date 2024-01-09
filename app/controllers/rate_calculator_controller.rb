class RateCalculatorController < ApplicationController
  def form
    @rate_calculator = RateCalculator.new
  end
end