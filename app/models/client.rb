class Client < ApplicationRecord
  belongs_to :user
  validates :name, :hours_worked, :amount_billed, :user_id, presence: true
  validates :hours_worked, :amount_billed, numericality: { greater_than_or_equal_to: 0.5 }

  class << self
    def create_for(params, user_id)
      new.tap do |client|
        client.name = params[:name]
        client.hours_worked = params[:hours_worked]
        client.amount_billed = params[:amount_billed]
        client.user_id = user_id
        client.rate = (client.amount_billed / client.hours_worked).round(2)
        client.save!
      end
    end
  end

  def update_for(params)
    self.name = params[:name]
    self.hours_worked = params[:hours_worked]
    self.amount_billed = params[:amount_billed]
    self.rate = (self.amount_billed / self.hours_worked).round(2)
    self.save!
  end

end
