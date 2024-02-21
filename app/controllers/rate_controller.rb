class RateController < ApplicationController
  before_action :set_rate, except: [:create, :index, :new]
  before_action :set_user, except: [:index, :show, :update, :destroy]

  def index
  end

  def new
    if @user_id != nil
      rate = Rate.find_by(user_id: @user_id)
      if rate.user_id != nil
        redirect_to edit_rate_path(rate.id)
      end
    end
  end

  def create
    @rate = Rate.create_for(expenses: expenses_params, hours: hours_params, earnings: earnings_params)

    if @user_id != nil  
      @rate.assign_user_id(@user_id)
    end

    redirect_to show_rate_path(@rate)
  end

  def show
  end

  def edit
    if @user_id != nil
      @rate = Rate.find_by(user_id: @user_id)
    end
    @rate_input = @rate.input
  end

  def update
    @rate.update_for(expenses: expenses_params, hours: hours_params, earnings: earnings_params)

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

  def set_user
    @user_id = session[:user_id]
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