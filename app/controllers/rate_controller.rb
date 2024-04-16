class RateController < ApplicationController
  skip_before_action :authorize, only: [:index]
  before_action :set_rate, except: [:index, :new, :create]

  def index
  end

  def new
    if Current.user.rate
      redirect_to edit_rate_path(Current.user.rate), notice: "Looks like you have already created a rate. You can edit it here."
    end
  end

  def create
    @rate = Rate.create_for(expenses: expenses_params, hours: hours_params, earnings: earnings_params)
    current_user.rate = @rate

    redirect_to @rate
  end

  def show
  end

  def edit
    @rate = Current.user.rate
    @rate_input = @rate.input
  end

  def update
    @rate.update_for(expenses: expenses_params, hours: hours_params, earnings: earnings_params)

    redirect_to @rate
  end

  def destroy
    @rate.destroy

    redirect_to root_path
  end

  private

  def set_rate
    @rate = Current.user.rate
  end

  def expenses_params
    params.require(:expenses).permit(:annual, :monthly, long_term: [:amount, :years])
  end

  def hours_params
    params.require(:hours).permit(:hours_day, :non_billable, :days_week, :holidays, :training, :sick)
  end

  def earnings_params
    params.require(:earnings).permit(:net_month, :tax_percent)
  end
end