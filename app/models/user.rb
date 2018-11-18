class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :celebrations, dependent: :destroy
  acts_as_token_authenticatable
  validates :email, :password, presence: true
  validates_uniqueness_of :email
  mount_base64_uploader :avatar, PictureUploader 
  mount_base64_uploader :lover_avatar, PictureUploader 
end
