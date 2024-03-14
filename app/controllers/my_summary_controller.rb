class MySummaryController < ApplicationController

  def index
    @user_id = session[:user_id]
    @rate = Rate.find_by(user_id: @user_id)
    user = User.find_by(id: @user_id)
    @username = user.name
    @clients = Client.where(user_id: @user_id)
    @message = client_rate_message(@rate, @clients)
  end

  private

    def client_rate_message(rate, clients)
      if clients.empty? || !rate
        return ""
      end

      rate_evaluation = evaluate_rates(rate, clients)

      if rate_evaluation == "poor" 
        return below_goal_message
      elsif rate_evaluation == "intermediate"
        return above_and_below_goal_message
      elsif rate_evaluation == "good"
        return above_goal_message
      end
    end

    def evaluate_rates(rate, clients)
      client_rates = clients.map(&:rate).sort

      if client_rates.first > rate.rate
        return "good"
      elsif client_rates.last < rate.rate
        return "poor"
      else
        return "intermediate"
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
