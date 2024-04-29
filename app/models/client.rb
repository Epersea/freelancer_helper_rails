class Client < ApplicationRecord
  include RateSetter
  
  belongs_to :user
  has_many :projects, dependent: :destroy
  validates :name, :user_id, presence: true
  before_save :set_defaults

  def update_stats
    self.hours_worked = 0
    self.amount_billed = 0

    self.projects.each do |project|
      self.hours_worked += project.hours_worked
      self.amount_billed += project.amount_billed
    end

    set_rate
    
    self.save!
  end

  private
    def set_defaults
      self.hours_worked = 0 if self.hours_worked.blank?
      self.amount_billed = 0 if self.amount_billed.blank?
      self.rate = 0 if self.rate.blank?
    end
end
