class Client < ApplicationRecord
  include RateSetter
  
  belongs_to :user
  has_many :projects, dependent: :destroy
  validates :name, :user_id, presence: true
  validates :hours_worked, :amount_billed, numericality: { greater_than_or_equal_to: 0 }
  before_validation :set_defaults

  def update_stats
    self.hours_worked = 0
    self.amount_billed = 0

    self.projects.each do |project|
      self.hours_worked += project.hours_worked
      self.amount_billed += project.amount_billed
    end
    
    self.save!
  end

  private
    def set_defaults
      self.hours_worked = 0 if self.hours_worked.blank?
      self.amount_billed = 0 if self.amount_billed.blank?
    end
end
