class RateController < ApplicationController
  before_action :find_rate, except: [:create, :index, :new]

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
    user_info = get_user_info(params)
    rate.user_info = user_info
    
    rate_calculator = RateCalculator.new(user_info)
    results = rate_calculator.do

    results.each do |key, value|
      rate.send("#{key}=", value) if rate.respond_to?("#{key}=")
    end

    rate.save
  end

  def get_user_info(params)
    user_info = {}
    user_info["expenses"] = params["expenses"]
    user_info["hours"] = params["hours"]
    user_info["earnings"] = params["earnings"]

    user_info
  end
end