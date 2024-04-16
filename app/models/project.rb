class Project < ApplicationRecord
  belongs_to :client
  validates :name, :hours_worked, :amount_billed, :client_id, presence: true
  validates :hours_worked, :amount_billed, numericality: { greater_than_or_equal_to: 0.5 }
  after_save :update_client_stats

  def update_client_stats
    client = self.client

    client.update_stats
  end
end
