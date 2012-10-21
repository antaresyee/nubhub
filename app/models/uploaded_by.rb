class UploadedBy < ActiveRecord::Base
  attr_accessible :note_id, :user_email

  belongs_to :uploader, class_name: "User"
  belongs_to :note

  validates :note_id, presence: true
  validates :user_email, presence: true
end
