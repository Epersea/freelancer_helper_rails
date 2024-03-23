class RateController < ApplicationController
  skip_before_action :authorize
  before_action :set_rate, except: [:create, :index, :new]
  before_action :set_logged_user, except: [:index, :show, :update, :destroy]

  def index
  end

  def new
    if @user_id && rate_for_user
      redirect_to edit_rate_path(rate_for_user), notice: "Looks like you have already created a rate. You can edit it here."
    end
  end

  def create
    @rate = Rate.create_for(expenses: expenses_params, hours: hours_params, earnings: earnings_params)

    if @user_id  
      @rate.assign_user_id(@user_id)
    end

    redirect_to @rate
  end

  def show
  end

  def edit
    if @user_id
      @rate = Rate.find_by(user_id: @user_id)
    end
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
    @rate = Rate.find(params[:id])
  end

  def rate_for_user
    Rate.find_by(user_id: @user_id)
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