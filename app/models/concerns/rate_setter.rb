module RateSetter
  extend ActiveSupport::Concern

  included do
    before_save :set_rate
  end

  private
    def set_rate
      self.rate = (self.amount_billed / self.hours_worked).round(2)
    end
end