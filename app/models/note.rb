class Note < ActiveRecord::Base
  attr_accessible :class_num, :upload, :department, :number_downloads
  has_attached_file :upload
  belongs_to :user

  validates :upload, presence: true
  validates :user_id, presence: true

  default_scope order: 'notes.created_at DESC'
  
  include Rails.application.routes.url_helpers

  def to_jq_upload 
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE"
    }
  end


=begin
  def self.save(upload)
  	name = upload['datafile']
  	directory = 'public/data'

  	path = File.join(directory, name)

  	File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
=end


end

