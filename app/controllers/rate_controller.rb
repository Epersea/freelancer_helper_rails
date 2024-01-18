class RateController < ApplicationController
  def index
  end
  
  def new
  end

  def create
    rate_id = get_rate_id

    rate_calculator = RateCalculator.new(params, rate_id)
    rate_calculator.create

    @rate = Rate.find(rate_id)

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

    rate_calculator = RateCalculator.new(params, rate_id)
    rate_calculator.update

    @rate = Rate.find(rate_id)

    redirect_to show_rate_path(@rate)
  end

  def destroy
    rate_id = params[:id]
    rate = Rate.find(rate_id)
    rate.destroy

    redirect_to root_path
  end

  private

  def get_rate_id
    last_rate_id = Rate.last.id
    current_rate_id = last_rate_id + 1

    current_rate_id
  end
end