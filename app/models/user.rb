class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :celebrations, dependent: :destroy

  validates :email, :password, presence: true
  validates_uniqueness_of :email
  
end
