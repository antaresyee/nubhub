class Note < ActiveRecord::Base
  attr_accessible :content, :user_id, :file

  validates :user_id, :presence => true
  mount_uploader :file, FileUploader
end
