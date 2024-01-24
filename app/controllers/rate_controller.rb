class RateController < ApplicationController
  before_action :set_rate, except: [:create, :index, :new]

  def index
  end

  def new
  end

  def create
    @rate = Rate.create_for(rate_input)

    redirect_to show_rate_path(@rate)
  end

  def show
  end

  def edit
    @rate_input = @rate.user_info
  end

  def update
    @rate.update_input(rate_input)

    redirect_to show_rate_path(@rate)
  end

  def destroy
    @rate.destroy

    redirect_to root_path
  end

  private

  def set_rate
    @rate = Rate.find(params[:id])
  end

  def add_calculations_to_rate(rate)
    input = rate_input
    rate.user_info = input
    
    rate_calculator = RateCalculator.new(input)
    results = rate_calculator.do

    results.each do |key, value|
      rate.send("#{key}=", value) if rate.respond_to?("#{key}=")
    end

    rate.save
  end

  def rate_input
    rate_input = {}
    rate_input["expenses"] = expenses_params
    rate_input["hours"] = hours_params
    rate_input["earnings"] = earnings_params

    rate_input
  end

  def expenses_params
    params.require(:expenses).permit(:annual, :monthly, long_term: [:amount, :years])
  end

  def hours_params
    params.require(:hours).permit(:hours_day, :non_billable, :days_week, :holidays, :training, :sick)
  end

  def earnings_params
    params.require(:earnings).permit(:net_monthly_salary, :tax_percent)
  end
end