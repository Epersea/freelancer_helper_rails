class User < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :email, :password_digest, presence: true
  
  has_one :rate, dependent: :destroy
  has_many :client, dependent: :destroy
  has_secure_password
end
