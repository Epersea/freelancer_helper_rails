class Project < ApplicationRecord
  belongs_to :client, dependent: :destroy
  validates :name, :hours_worked, :amount_billed, :client_id, presence: true
  validates :hours_worked, :amount_billed, numericality: { greater_than_or_equal_to: 0.5 }
end
