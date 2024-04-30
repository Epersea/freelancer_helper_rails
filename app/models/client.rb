class Client < ApplicationRecord
  include RateSetter
  
  belongs_to :user
  has_many :projects, dependent: :destroy
  validates :name, :user_id, presence: true

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
end
