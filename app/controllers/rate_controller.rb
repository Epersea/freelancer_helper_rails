class RateController < ApplicationController
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
    @rate = Rate.find(params[:id])
  end

  def edit
    @rate = Rate.find(params[:id])
  end

  def update
    rate_id = params[:id]
    @rate = Rate.find(rate_id)

    add_calculations_to_rate(@rate, params)

    redirect_to show_rate_path(@rate)
  end

  def destroy
    rate_id = params[:id]
    rate = Rate.find(rate_id)
    
    rate.destroy

    redirect_to root_path
  end

  private

  def add_calculations_to_rate(rate, user_info)
    rate_calculator = RateCalculator.new(user_info)
    results = rate_calculator.do

    results.each do |key, value|
      rate.send("#{key}=", value) if rate.respond_to?("#{key}=")
    end

    rate.save
  end
end