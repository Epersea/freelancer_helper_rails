class Client < ApplicationRecord
  belongs_to :user
  validates :name, :hours_worked, :amount_billed, presence: true
  validates :hours_worked, :amount_billed, numericality: true
end
