class RateCalculatorController < ApplicationController
  def new
    @rate_calculator = RateCalculator.new
  end

  def create
    long_term = calculate_long_term(params["long_term"])
    annual = params["annual"]
    monthly = params["monthly"]
   
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

  private

  def calculate_long_term(expenses)
    total_expenses = 0
    
    expenses.each do |expense|
      total_expenses += expense["amount"].to_i
    end

    total_expenses
  end

end