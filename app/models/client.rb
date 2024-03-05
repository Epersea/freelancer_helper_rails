class Client < ApplicationRecord
  belongs_to :user
  validates :name, :hours_worked, :amount_billed, :user_id, presence: true
  validates :hours_worked, :amount_billed, numericality: { greater_than_or_equal_to: 0.5 }
end
