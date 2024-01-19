class RateController < ApplicationController
  before_action :find_rate, except: [:create, :index, :new]

  def create
    @rate = Rate.new

    add_calculations_to_rate(@rate, params)

    redirect_to show_rate_path(@rate)
  end

  def edit
    @user_info = @rate.user_info
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

  def find_rate
    @rate = Rate.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end

  def add_calculations_to_rate(rate, params)
    rate_calculator = RateCalculator.new(params)
    results = rate_calculator.do

    results.each do |key, value|
      rate.send("#{key}=", value) if rate.respond_to?("#{key}=")
    end

    params.delete("controller")
    params.delete("action")
    @rate.user_info = params
    @rate.save

    rate.save
  end
end