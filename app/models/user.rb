class User < ApplicationRecord
  has_many :celebrations, dependent: :destroy

  validates :email, :password, presence: true
  validates_uniqueness_of :email
  mount_base64_uploader :avatar, PictureUploader 
end
