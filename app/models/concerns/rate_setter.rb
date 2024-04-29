module RateSetter
  extend ActiveSupport::Concern

  private
    def set_rate
      self.rate = (self.amount_billed / self.hours_worked).round(2)
    end
end