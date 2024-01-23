class RateController < ApplicationController
  before_action :set_rate, except: [:create, :index, :new]

  def index
  end

  def new
  end

  def create
    @rate = Rate.new

    add_calculations_to_rate(@rate, params)

    redirect_to show_rate_path(@rate)
  end

  def show
  end

  def edit
    @rate_input = @rate.user_info
  end

  def update
    add_calculations_to_rate(@rate, params)

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

  def add_calculations_to_rate(rate, params)
    rate_input = get_rate_input(params)
    rate.user_info = rate_input
    
    rate_calculator = RateCalculator.new(rate_input)
    results = rate_calculator.do

    results.each do |key, value|
      rate.send("#{key}=", value) if rate.respond_to?("#{key}=")
    end

    rate.save
  end

  def get_rate_input(params)
    rate_input = {}
    rate_input["expenses"] = params["expenses"]
    rate_input["hours"] = params["hours"]
    rate_input["earnings"] = params["earnings"]

    rate_input
  end
end