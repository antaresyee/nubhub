class Note < ActiveRecord::Base
  attr_accessible :class_num, :content, :department, :number_downloads
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true

  default_scope order: 'notes.created_at DESC'

end
