class User < ApplicationRecord
  has_many :celebrations, dependent: :destroy

  validates :email, :password, presence: true
end
