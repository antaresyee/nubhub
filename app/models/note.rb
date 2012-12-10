class Note < ActiveRecord::Base
  attr_accessible :file, :downloads
  belongs_to :user
  belongs_to :course

  has_many :download_relationship, dependent: :destroy
  has_many :users, through: :download_relationship

  validates :user_id, :presence => true
  validates :course_id, :presence => true
  mount_uploader :file, FileUploader


  def fileBasename
  	File.basename(self.file.to_s)
  end

  def formatDate
  	self.updated_at.strftime('%m/%d/%Y')
  end

  def numberDownloads
  	self.users.count
  end

end
