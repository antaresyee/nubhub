class DownloadRelationship < ActiveRecord::Base
	attr_accessible :note_id, :user_id
	belongs_to 	:note, class_name: "Note"
	belongs_to 	:user, class_name: "User"
end
