class Project < ApplicationRecord
  include RateSetter

  belongs_to :client
  validates :name, :hours_worked, :amount_billed, :start_date, :end_date, :client_id, presence: true
  validates :hours_worked, :amount_billed, numericality: { greater_than_or_equal_to: 0.5 }
  validate :start_date_before_end_date
  after_save :update_client_stats
  after_destroy :update_client_stats

  private
    def start_date_before_end_date
      if start_date && end_date && start_date > end_date
        errors.add(:start_date, "must be before or the same as end date")
      end
    end

    def update_client_stats
      client = self.client

      client.update_stats
    end
end
