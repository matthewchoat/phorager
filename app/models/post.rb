class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :message, presence: true

  belongs_to :user
end
