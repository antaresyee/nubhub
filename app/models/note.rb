class Note < ActiveRecord::Base
  attr_accessible :content, :file
  belongs_to :user

  validates :user_id, :presence => true
  mount_uploader :file, FileUploader
end
