class Client < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :projects
  validates :name, :hours_worked, :amount_billed, :user_id, presence: true
  validates :hours_worked, :amount_billed, numericality: { greater_than_or_equal_to: 0.5 }
  before_save :set_rate

  private
    def set_rate
      self.rate = (self.amount_billed / self.hours_worked).round(2)
    end
end
