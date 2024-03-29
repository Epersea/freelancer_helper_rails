class User < ApplicationRecord
  validates :name, :email, uniqueness: true
  validates :name, :email, :password_digest, presence: true
  
  has_one :rate, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_secure_password
end
