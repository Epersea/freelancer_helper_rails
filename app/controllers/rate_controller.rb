class RateController < ApplicationController
  skip_before_action :authorize
  before_action :set_rate, except: [:create, :index, :new]
  before_action :set_user, except: [:index, :show, :update, :destroy]

  def index
  end

  def new
    if @user_id && Rate.find_by(user_id: @user_id)
      redirect_to my_summary_path, notice: "Looks like you have already created a rate. You can edit it at the link below."
    end
  end

  def create
    @rate = Rate.create_for(expenses: expenses_params, hours: hours_params, earnings: earnings_params)

    if @user_id  
      @rate.assign_user_id(@user_id)
    end

    redirect_to show_rate_path(@rate)
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