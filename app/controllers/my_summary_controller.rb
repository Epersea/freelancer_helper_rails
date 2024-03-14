class MySummaryController < ApplicationController

  def index
    @user_id = session[:user_id]
    @rate = Rate.find_by(user_id: @user_id)
    user = User.find_by(id: @user_id)
    @username = user.name
    @clients = Client.where(user_id: @user_id)
    @message = client_rate_message
  end

  private

    def client_rate_message
      if @clients.empty? || !@rate
        return nil
      else
        return evaluate_rates
      end
    end

    def evaluate_rates
      client_rates = @clients.map(&:rate).sort
      
      lowest_rate = client_rates.first
      highest_rate = client_rates.last

      if lowest_rate > @rate.rate
        return above_goal_message
      elsif highest_rate < @rate.rate
        return below_goal_message
      else
        return above_and_below_goal_message
      end
    end

    def above_goal_message
      "All your clients are above your goal rate. Good job! Why not being a bit more ambitious?"
    end

    def below_goal_message
      "All your clients are below your goal rate. It's time to give yourself a raise!"
    end

    def above_and_below_goal_message
      "Some of your clients are below your goal rate. Maybe you need to brush up your negotiation skills a bit?"
    end
end
